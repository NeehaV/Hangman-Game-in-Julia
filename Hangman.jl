function getWord()
    animal = ("ANACONDA", "ASIAN ELEPHANT", "BENGAL TIGER", "BUTTERFLY", "CRAYFISH", "EAGLE", "FLAMINGO", "FOX SQUIRREL", "SHEPHERD", "HEDGEHOG")
    profession = ("BUTCHER", "DENTIST", "FACTORY WORKER", "LIFEGUARD", "BRICKLAYER", "ASTRONOMER", "POLITICIAN", "VETERINARY DOCTOR", "SCIENTIST", "NEWSREADER")
    fruits = ("APRICOT", "PISTACHIO", "POPPY SEEDS", "CRANBERRY", "NECTARINES")
    vegetables = ("CAULIFLOWER", "BOTTLE GOURD", "DRUMSTICK", "ZUCCHINI", "BROCCOLI")

    word = " "
    sectionName = " "
    while word == " "
        section = rand(1:4)

        if(section == 1)
            sectionName = "Animal or bird"
            wordPosition = rand(1:length(animal))
            word = animal[wordPosition]
        elseif(section==2)
            sectionName = "Profession"
            wordPosition = rand(1:length(profession))
            word = profession[wordPosition]
        elseif(section==3)
            sectionName = "Fruit"
            wordPosition = rand(1:length(fruits))
            word = fruits[wordPosition]
        elseif(section==4)
            sectionName = "Vegetable"
            wordPosition = rand(1:length(vegetables))
            word = vegetables[wordPosition]
        else
            word = " "
        end
    end

    return word, sectionName
end
function printResultArray(resultArray)
    
    print("       ")
    for i in eachindex(resultArray)
        if resultArray[i] == ' '
            print(" ")
        end
        print("$(resultArray[i]) ")
    end
    println()
    
end
function showHangman(errCount::Int64)
    println()
    if (errCount==0)
    println("       ----")
    println()
    println()
    println()
    println()
    println()
    elseif (errCount==1)
        println("       ----")
        println("          |")
        println()
        println()
        println()
        println()
        println()
    elseif (errCount==2)
        println("       ----")
        println("          |")
        println("          O")
        println()
        println()
        println()
        println()
    elseif (errCount==3)
        println("       ----")
        println("          |")
        println("          O")
        println("         /")
        println()
        println()
        println()
    elseif (errCount==4)
        println("       ----")
        println("          |")
        println("          O")
        println("         /|")
        println()
        println()
        println()
    elseif (errCount==5)
        println("       ----")
        println("          |")
        println("          O")
        println("         /|\\")
        println()
        println()
        println()
    elseif (errCount==6)
        println("       ----")
        println("          |")
        println("          O")
        println("         /|\\")
        println("          |")
        println()
        println()
    elseif (errCount==7)
        println("       ----")
        println("          |")
        println("          O")
        println("         /|\\")
        println("          |")
        println("         /")
        println()
    elseif (errCount==8)
        println("       ----")
        println("          |")
        println("          O")
        println("         /|\\")
        println("          |")
        println("         / \\")
        println()
    end
end
function clc()
    if Sys.iswindows()
        return read(run(`powershell cls`), String)
    elseif Sys.isunix()
        return read(run(`clear`), String)
    elseif Sys.islinux()
        return read(run(`printf "\033c"`), String)
    end
end
function checkGameStatus(resultArray, answerWord)

    countCharacters = 0
     for i in eachindex(resultArray)
        if answerWord[i] == resultArray[i]
            countCharacters +=1
        end
    end
    if countCharacters == length(answerWord)
        return true
    else
        return false
    end
    
end
function checkGuess(guess, answerWord)

    status = false

    for i in eachindex(answerWord)
        if guess == answerWord[i]
            status = true
            break
        end
    end
    return status

end


 

function hangman()
    
    choice = "Y"
    guess = " "
    while(choice=="Y")
        guessChoice = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
        errorCount = 0
        gameStatus = false

        answer = getWord()
        answerWord = answer[1]
        answerSection= answer[2]
        resultArrayLength = length(answerWord)

        resultArray = Array{Char}(undef, resultArrayLength)
        for i = 1 : resultArrayLength
            resultArray[i] = '_'
            if answerWord[i] == ' '
                resultArray[i] = ' '
            end
        end

        while true
            clc()
            println("-------------------------------------")
            println("               HANGMAN")
            println("-------------------------------------")
            println("           $answerSection")

            printResultArray(resultArray)
            showHangman(errorCount)

            println("-------------------------------------")
            for i in eachindex(guessChoice)
                print("$(guessChoice[i])  ")
                if(i==13)
                    println()
                end
            end
            println()
            println("-------------------------------------")

            gameStatus = checkGameStatus(resultArray, answerWord)

                
            if errorCount == 8
                println(" *** YOU FAILED! ***")
                println("Answer is: $answerWord")
                break
            elseif gameStatus == true
                println(" *** YOU WON THE GAME! ***")
                break
            else
                
                available = true

                while available
                    
                    print("Enter your guess: ")
                    guessed = readline()
                    guess = uppercase(only(guessed))
                    for i in eachindex(guessChoice)
                        if guess == guessChoice[i]
                            guessChoice = replace(guessChoice, guess=>'_')
                            available = false
                            break
                        end
                    end
                    if available == true
                        println("Please select available choices from the box!")
                    end
                end
    
                guessStatus = checkGuess(guess, answerWord)
                
                if guessStatus != true
                    errorCount = errorCount + 1
                else
                    for i in eachindex(resultArray)
                        if answerWord[i] == guess
                            resultArray[i] = guess
                        end
                    end
                end
            end
                
        end
            
        choice = " "
        while (choice != "Y") && (choice != "N")
            print("Do you want to play again(Y/N)?: ")
            ip = readline()
            choice = uppercase(ip)
        end
    end

    println("Thanks for playing")

end

hangman()