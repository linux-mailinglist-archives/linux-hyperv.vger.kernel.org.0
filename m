Return-Path: <linux-hyperv+bounces-5768-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306F9ACDEBE
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B357A1F24
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3AA28F52A;
	Wed,  4 Jun 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUazGoVC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6128F508
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Jun 2025 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042756; cv=none; b=gibd+r5LBvG+39ROjVlLi8KM/XbCi7K3CWu2tBJ2DzCQ3w1Z4ICtVq+IeGijjpmvg9iohUFCs3Vo+1hYrmkgsP0JeiBDmLwB2F3a+wLQsEH4KVkihYHwjJDGZTPC3IpD4Q6BgkUS6YnZKpKwVvv5CQBEXxYSFm5Ujkb8z7UIfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042756; c=relaxed/simple;
	bh=7cO10VLbVc8GP15c1+QczRv+smPUZcdBCRLmjBmbq9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3byU+vLQcusde1o4kOC/eP3PBHb00EzLHSnXGAa7BPQngj8fvlveE7VsDQ/oMSVOviZJoL2bTx3XtFFxSgIw8LHpwXzkLXf74Jqv40nt4nScI/CRZtc7ICtyCBLuSc+eextB2ibqqBJuZf+YNgUW0k6p9Mauo07+bH/bu4PjHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUazGoVC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so6423017a12.0
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Jun 2025 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749042754; x=1749647554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Od8KUd/AcaJnEjoGNafGoIcmAEiB0kps/pv2vqBwX2o=;
        b=IUazGoVCwcSXG2pk4mMr4QTea0pVPSOCc2BQLKZBgjO9X7ZnZ5QwmuXRRvZ9rDH5Hc
         LTtxP71YE2Fx8u72rq6m9DgtEB88zT+/Nd9FHO89mZS959Wp6T4fedWtQYxn+WzPJdJz
         yourFi7R6iXD5ccin2WFmqW8A/A0IbGa1X/tkU+57xVsKHDkfiwaNV9UECAawv+XKnaJ
         FCUOaQXc/TtElB26lcXnw8i3vN7jDve0qjnSqoyEqsPID+GdeEqI7UeylcwzplUl1sqe
         +xkFZzpmRwV9Vh27QNFh0uRErtScbsMb1MabGPlDPF8Rwg3HNYU9BO3bnO9vSYk8tjqZ
         tFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749042754; x=1749647554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Od8KUd/AcaJnEjoGNafGoIcmAEiB0kps/pv2vqBwX2o=;
        b=CvHQeKR7kwN2uvnaPOgVgfHnzjQu24CA6j++4g7Fx3MVZOOM7Tvg4oqtOYhf1XyGHA
         a2LnmaMFgaSY+433P+wsxtXJHQR/mo6ukpgZR2/mkO3aGgTL7gQD1QDeth66l77rjxPn
         ZAf53acMAaLVgV9jEa3eNIf7DVLjndKA6xjLgljRux8yScDzq0xghs03Rbh0u8Z4ot+8
         yjcbC9ya5qadrWKU0X7V7EphZrVlx2tS61xD+4dRuShK1fjrSiAsWYxQe2/go7PRys+G
         WZuG/VK6ROoy1Bl5y+SBR2yGd6/WJvhLZhXludC+ztecutyJ7Dprc301X/8/Kzb4F1wc
         DEZg==
X-Forwarded-Encrypted: i=1; AJvYcCUio/vim72UT3/T54Ti19qWR4wIfjVO4rsxV7pygOmJEePpB60HONNwhmaoAYndm2UuiqCoOZZfRpph2AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdi9tmaNSiLplZWpEu8P9vlGaJSBfHkaWqzTKXZst443pJPfWd
	z4DvLYagsv6WhJ5IjRWp2hfThYwLlpGJvlCKG9pDL0deWNf4Z89vkILp
X-Gm-Gg: ASbGncuU3k6Q5ceUmUcT/iCG6bl/9EyX/PknNBR4y3qpQ47ZdEabT3RFMrRv92OMLiE
	qLWdVOz4LVKhAC/cr2PdcH5Xpp8NZPp98TFu8b1SOoJ5/lNxbGvQS0OfgTEfJAAHmnvEg9FfLVc
	8tSxKw8aa+E9bopenBG/ro/cT2xXLnH2SkhZYM+6AAC+QM+2G1/f9yPz/HK8e0FzxZt0BV5kQ0G
	fUWUB0sqys5Imofe/TD0EbDTO+SX9qdBB9PZolt7icrOKT3JjCcLyt2QouI0Xuaqq2qxRlsTk9o
	Le/h1SfE2D0rqeWp41oB2FBaLQOL7ZfJQh4Hdrz+RB2ZwHOx60gy5ZZZp+mOZ9eLV2w57yJi8A0
	AiRj6+pCWhUMAtHuqJ2IU0pcuHUmI4w==
X-Google-Smtp-Source: AGHT+IHMKxZxxNE6ffKl78m7bQU65x/pzRHM6n6rT2P1qt4umDbATAaP43wofGG0DcOc4OX2KCWdHw==
X-Received: by 2002:a05:6a21:328b:b0:20b:9774:ac6c with SMTP id adf61e73a8af0-21d22aa2f8bmr3949045637.5.1749042753540;
        Wed, 04 Jun 2025 06:12:33 -0700 (PDT)
Received: from ?IPV6:2400:4051:8da4:6b00:2902:f920:826c:8696? ([2400:4051:8da4:6b00:2902:f920:826c:8696])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab6b2sm11434562b3a.57.2025.06.04.06.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 06:12:33 -0700 (PDT)
Message-ID: <47c57a1b-2503-4a00-8550-8a3edb6ba305@gmail.com>
Date: Wed, 4 Jun 2025 22:12:30 +0900
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hv_fcopy_uio_daemon: Fix file copy failure between
 Windows host and Linux guest
To: Naman Jain <namjain@linux.microsoft.com>, eahariha@linux.microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, linux-hyperv@vger.kernel.org,
 ssengar@linux.microsoft.com
References: <e174e3b0-6b62-4996-9854-39c84e10a317@linux.microsoft.com>
 <20250603234300.1997-1-yasuenag@gmail.com>
 <20250603234300.1997-2-yasuenag@gmail.com>
 <581033c2-4ff4-44c8-a33c-02da3461fb51@linux.microsoft.com>
 <72f78577-ec5e-43a3-9378-a77e003b05a6@gmail.com>
 <fe8524f6-3f5f-4266-b9e5-f200ba04e1a9@linux.microsoft.com>
Content-Language: en-US
From: Yasumasa Suenaga <yasuenag@gmail.com>
In-Reply-To: <fe8524f6-3f5f-4266-b9e5-f200ba04e1a9@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Naman,

Thanks a lot for your help!

I will fix for your comment, and send as v4 patch next week :)

> Please help me understand if this is correct. The actual problem you are highlighting lies here when sizeof(wchat_t) is more than 16, i.e. 32?

Yes, so we should not cast array of __u16 to wchar_t*.
I confirmed it on Linux as following:
```
[yasuenag@fc42 sizeof]$ cat test.c
#include <stdio.h>
#include <stddef.h>

int main(){
   printf("%ld\n", sizeof(wchar_t));
   return 0;
}
[yasuenag@fc42 sizeof]$ rpm -q gcc
gcc-15.1.1-2.fc42.x86_64
[yasuenag@fc42 sizeof]$ gcc test.c
[yasuenag@fc42 sizeof]$ ./a.out
4
```

In Windows, it returns 2:
```
PS C:\test\sizeof> cl.exe .\test.c
Microsoft(R) C/C++ Optimizing Compiler Version 19.44.35208 for x86
Copyright (C) Microsoft Corporation.  All rights reserved.

test.c
Microsoft (R) Incremental Linker Version 14.44.35208.0
Copyright (C) Microsoft Corporation.  All rights reserved.

/out:test.exe
test.obj
PS C:\test\sizeof> .\test.exe
2
```


Thanks,

Yasumasa


On 2025/06/04 21:36, Naman Jain wrote:
> 
> 
> On 6/4/2025 2:40 PM, Yasumasa Suenaga wrote:
>> Hi Naman,
>> Sorry for bothering you, but I have some questions:
>>
>>
> 
> Hi,
> Happy to help. I have tested your patch on my setup, and it did not break anything for me. Please find response and additional questions inline.
> 
> 
>>> 1. Create a new patch file for every new version and then send it.
>>> Currently it seems you are manually editing the same patch file in the
>>> subject and sending it, so each patch version is showing up in the same
>>> thread.
>>
>> I've committed changes with "git amend" and created formatted patch with "git format-patch",
>> then I sent all of *.patch files via "git send-email".
>> Do you mean I should commit to fix commits reviewers and send cover letter and incremental
>> patches only? I couldn't find about it from the guide.
>> I checked linux-hyperv list, all of patches have been sent in each version AFAICS.
>>
> 
> * make changes
> * git add, git commit, git format-patch, git send-email <path to v1 patch)
> * make changes for v2
> * git add, git commit --amend, git format-patch -v2, git send-email <path to v2 patch *only*>
> and so on.
> 
> I follow above practice, and the patches go in new threads. I am not sure why they are landing in same thread for you. Anyhow, its not a big thing.
> 
>>
>>> 3. Keep a minimum of 1-2 weeks gap between successive patch versions to
>>> give time to people to review your changes.
>>
>> Does it include changes of commit message too?
> 
> Other reviewers may be reviewing older versions and it becomes confusing if new versions come too soon. To give everyone enough time to review your changes and to not have unnecessary patch versions, its better to wait for a few days, collect the feedback and address it together. We also need to mention what we changed since last time, to help reviewers know if their comments got addressed.
> 
> For single patch, we usually don't add a cover letter. You can refer
> https://lore.kernel.org/all/20250102145243.2088-1-namjain@linux.microsoft.com/
> The comments between the two "---" does not make it to git log.
> 
>>
>>
>>> 4. In the commit msg of v3, it is still not very clear what problem, you
>>> are trying to fix here. Do you mean to say that fcopy does not work on
>>> Linux? Or you are assuming it won't work and fixing some generic
>>> problem?
>>> Fcopy is supposed to work fine on Linux VM on HyperV with windows host. If there are some errors, please share in cover letter/comments
>>> in the patch along with steps of execution.
>>
>> I have a problem on my PC:
>>
>>    Host: Windows 11 Pro (24H2 build 26100.4202)
>>    Guest: Fedora 42
>>      - kernel-6.14.4-300.fc42.x86_64
>>      - hypervfcopyd-6.10-1.fc42.x86_64
>>
>> How to reproduce: run Copy-VMFile commandlet on Host:
>>
>> Following log is in Japanese because my PC is set to Japanese, sorry.
>> But it says fcopy could not transfer file (test.ps1) to /tmp/ on Linux guest because it already exists.
>> I confirmed /tmp/test.ps1 does not exist of course.
>>
>> ```
>>> Copy-VMFile
>>
>> cmdlet Copy-VMFile at command pipeline position 1
>> Supply values for the following parameters:
>> Name[0]: Fedora42
>> Name[1]:
>> SourcePath: test.ps1
>> DestinationPath: /tmp/
>> FileSource: Host
>> Copy-VMFile: ゲストへのファイルのコピーを開始できませんでした。
>>
>> ソース ファイル 'C:\test\test.ps1' をゲストの宛先 '/tmp/' にコピーできま せんでした。
>>
>> 'Fedora42' はゲスト: ファイルがあります。 (0x80070050) へのファイルのコ ピーを開始できませんでした。(仮想マシン ID 9BFDF23D-CCAA-4748- A770-6D654E09A133)
>>
>> 'Fedora42' は、コピー元ファイル 'C:\test\test.ps1' をゲスト上のコピー先 '/tmp/' にコピーできませんでした: ファイルがあります。 (0x80070050)。(仮 想マシン ID 9BFDF23D-CCAA-4748-A770-6D654E09A133)
>> ```
>>
>> I got following fcopy log from journald - it is strange because "/tmp/ test.ps1" should be shown here.
>> ```
>> 6月 04 17:48:24 fc42 HV_UIO_FCOPY[1080]: File: / exists
>> ```
>>
>> As I wrote in commit message, wchar_t is 32 bit in Linux. I confirmed it with "sizeof(wchar_t)".
>> However fcopyd handles it as 16 bit value (__u16), thus I think this is a bug in fcopy, and
>> I think it would also not work on other environments.
>>
>> Actually it works fine with my patch to handle values as 16 bit.
>>
>>
>> Thanks,
>>
>> Yasumasa
>>
>>
>> On 2025/06/04 15:19, Naman Jain wrote:
>>>
>>>
>>> On 6/4/2025 5:13 AM, yasuenag@gmail.com wrote:
>>>> From: Yasumasa Suenaga <yasuenag@gmail.com>
>>>>
>>>> Handle file copy request from the host (e.g. Copy-VMFile commandlet)
>>>> correctly.
>>>> Store file path and name as __u16 arrays in struct hv_start_fcopy.
>>>> Convert directly to UTF-8 string without casting to wchar_t* in fcopyd.
>>>>
>>>> Fix string conversion failure caused by wchar_t size difference between
>>>> Linux (32bit) and Windows (16bit). Convert each character to char
>>>> if the value is less than 0x80 instead of using wcstombs() call.
>>>>
>>>> Add new check to snprintf() call for target path creation to handle
>>>> length differences between PATH_MAX (Linux) and W_MAX_PATH (Windows).
>>>>
>>>> Signed-off-by: Yasumasa Suenaga <yasuenag@gmail.com>
>>>> ---
>>>>   tools/hv/hv_fcopy_uio_daemon.c | 37 ++++++++++++++--------------------
>>>>   1 file changed, 15 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/ hv_fcopy_uio_daemon.c
>>>> index 0198321d1..86702f39e 100644
>>>> --- a/tools/hv/hv_fcopy_uio_daemon.c
>>>> +++ b/tools/hv/hv_fcopy_uio_daemon.c
>>>> @@ -62,8 +62,11 @@ static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
>>>>       filesize = 0;
>>>>       p = path_name;
>>>> -    snprintf(target_fname, sizeof(target_fname), "%s/%s",
>>>> -         path_name, file_name);
>>>> +    if (snprintf(target_fname, sizeof(target_fname), "%s/%s",
>>>> +             path_name, file_name) >= sizeof(target_fname)) {
>>>> +        /* target file name is too long */
> 
> Please add a syslog for this. It will help in debugging issues.
> 
>>>> +        goto done;
>>>> +    }
>>>>       /*
>>>>        * Check to see if the path is already in place; if not,
>>>> @@ -273,6 +276,8 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
>>>>       while (len < dest_size) {
>>>>           if (src[len] < 0x80)
>>>>               dest[len++] = (char)(*src++);
>>>> +        else if (src[len] == '0')
>>>> +            break;
> 
> While this also works, I think you can add it to the while loop itself
> while (len < dest_size && src[len])
> 
> Is this related to the FCopy issue that you see or this is just a fix for correct destination file name?
> 
> 
>>>>           else
>>>>               dest[len++] = 'X';
>>>>       }
>>>> @@ -282,27 +287,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
>>>>   static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
>>>>   {
>>>> -    setlocale(LC_ALL, "en_US.utf8");
>>>> -    size_t file_size, path_size;
>>>> -    char *file_name, *path_name;
>>>> -    char *in_file_name = (char *)smsg_in->file_name;
>>>> -    char *in_path_name = (char *)smsg_in->path_name;
>>>> -
>>>> -    file_size = wcstombs(NULL, (const wchar_t *restrict)in_file_name, 0) + 1;
>>>> -    path_size = wcstombs(NULL, (const wchar_t *restrict)in_path_name, 0) + 1;
>>>> -
> 
> Please help me understand if this is correct. The actual problem you are highlighting lies here when sizeof(wchat_t) is more than 16, i.e. 32?
> 
>>>> -    file_name = (char *)malloc(file_size * sizeof(char));
>>>> -    path_name = (char *)malloc(path_size * sizeof(char));
>>>> -
>>>> -    if (!file_name || !path_name) {
>>>> -        free(file_name);
>>>> -        free(path_name);
>>>> -        syslog(LOG_ERR, "Can't allocate memory for file name and/or path name");
>>>> -        return HV_E_FAIL;
>>>> -    }
>>>> +    /*
>>>> +     * file_name and path_name should have same length with appropriate
>>>> +     * member of hv_start_fcopy.
>>>> +     */
>>>> +    char file_name[W_MAX_PATH], path_name[W_MAX_PATH];
>>>> -    wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
>>>> -    wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
>>>> +    setlocale(LC_ALL, "en_US.utf8");
>>>> +    wcstoutf8(file_name, smsg_in->file_name, W_MAX_PATH - 1);
>>>> +    wcstoutf8(path_name, smsg_in->path_name, W_MAX_PATH - 1);
>>>>       return hv_fcopy_create_file(file_name, path_name, smsg_in- >copy_flags);
>>>>   }
>>>
>>> Hi,
>>> I understand this is your first patch for upstreaming. Here are a few
>>> things you should consider:
>>> 1. Create a new patch file for every new version and then send it.
>>> Currently it seems you are manually editing the same patch file in the
>>> subject and sending it, so each patch version is showing up in the same
>>> thread.
>>> 2. Read, re-read, absorb the information in the link that Easwar also
>>> mentioned:
>>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>> 3. Keep a minimum of 1-2 weeks gap between successive patch versions to
>>> give time to people to review your changes.
>>> 4. In the commit msg of v3, it is still not very clear what problem, you
>>> are trying to fix here. Do you mean to say that fcopy does not work on
>>> Linux? Or you are assuming it won't work and fixing some generic
>>> problem?
>>> Fcopy is supposed to work fine on Linux VM on HyperV with windows host. If there are some errors, please share in cover letter/comments
>>> in the patch along with steps of execution.
>>>
>>> 5. If its a fix, we should have a proper Fixes tag with the commit you
>>> are fixing.
>>> 6. Have a look at existing conversations at lore to get to know common
>>> practices with single patch, multi patch, cover letters etc.
>>> https://lore.kernel.org/linux-hyperv/?q=linux-hyperv
>>>
>>> Regards,
>>> Naman
>>>
> 
> 
> Regards,
> Naman
>>>
> 


