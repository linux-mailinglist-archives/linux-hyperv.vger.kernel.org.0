Return-Path: <linux-hyperv+bounces-648-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DB87DBF18
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 18:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B901F22169
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81617199AA;
	Mon, 30 Oct 2023 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIKawmnC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D3199BA
	for <linux-hyperv@vger.kernel.org>; Mon, 30 Oct 2023 17:36:46 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1619D9;
	Mon, 30 Oct 2023 10:36:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc13149621so8542925ad.1;
        Mon, 30 Oct 2023 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698687405; x=1699292205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1r4Sk8mM752UlAqTKeehpaUyB9IeVemNOy9Th+/NVU=;
        b=PIKawmnC9wrcn/YpeAglQ9CaGWWEmmWN34/N+249o/xGW1eH8iuGGdfcfn7mAE02jR
         i5SzjcyU0FrUOdpiTkbalB7UURF3TzMtfvo2DA0tVsN64VEv9O8IZruy+Z/nWgQKIYv4
         1lG8zgBbSx7iMdTNONiAeM5M0A/2uNulGBq8Kpxac75OabrIXEBDp7XpmQak87t5jtEB
         ZkiBJZmDUs0+g7Sl/jpdSlQbryczZkf1SGVIU8iZh/HhX7UVkaWn4kiY9M60rmsPJG4W
         yZDA4AwyUt1a4Vngl1/gZZsUi8V1mILS/IozQ4X5nVMSzqtSrC6Fsq4GIumTb3JhhFPt
         pf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687405; x=1699292205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1r4Sk8mM752UlAqTKeehpaUyB9IeVemNOy9Th+/NVU=;
        b=G2oqEVwMvgIywjFXjqdA9fpIdQoC9LjZgOD+Zjtr3iTIYr4TGm/YecG8JHnMQ2Lznj
         g/Rxk2bFnLRfNo3sdWSx4B1TRLjDgu2n56cr2LAeCJmrHmPTwPg58q6rtiiDHLFHweLW
         Hb8zdbCvqhjE/lNKLGAgrf9htgCKBhVtel2yDQ2zdDBWyYxa6fGJJ8rDTXgpCAZSeErm
         5l+h3LGSyIoYMyEgOyt1f+diaM3HtKwvDEwe5u6n2I4RrJejMbIU4zYu3w8me1uHarx/
         6rIiAPICrfdvwjjRiVJMKK1JRLMmk78uBQh+gb9OxgWkp2LnugvZ+xF/IuRqfeA0X+c8
         CiXQ==
X-Gm-Message-State: AOJu0YzpeDG3Y4/aegtQr5DERCs+cSvoR1RcPwGuFaHZo44AyX9wt0iT
	6KOGcYxGbye5cz0oBkix/4Y=
X-Google-Smtp-Source: AGHT+IGgyg6TaKLNhotuA5o8+cZQH5PdN52kp121cXodu0M9i82nk3BWuXxmRGOHgLC+Tm/RaDq2xw==
X-Received: by 2002:a17:902:d1c2:b0:1cc:277f:b4f6 with SMTP id g2-20020a170902d1c200b001cc277fb4f6mr8469796plb.6.1698687405251;
        Mon, 30 Oct 2023 10:36:45 -0700 (PDT)
Received: from [192.168.0.152] ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b001c62d63b817sm2690271plg.179.2023.10.30.10.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 10:36:44 -0700 (PDT)
Message-ID: <e2598cb7-d02a-4520-99da-384886e9fc4c@gmail.com>
Date: Mon, 30 Oct 2023 23:06:34 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixing warning cast removes address space '__iomem' of
 expression
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 Nischala Yelchuri <Nischala.Yelchuri@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20231024112832.737832-1-singhabhinav9051571833@gmail.com>
 <SN6PR2101MB16937C421EA9CDF373835360D7A3A@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <19cec6f0-e176-4bcc-95a0-9d6eb0261ed1@gmail.com>
 <BYAPR21MB16885EA9FFD1DFD60CF2F263D7A1A@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Language: en-US
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <BYAPR21MB16885EA9FFD1DFD60CF2F263D7A1A@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/23 22:08, Michael Kelley (LINUX) wrote:
> From: Abhinav Singh <singhabhinav9051571833@gmail.com> Sent: Saturday, October 28, 2023 2:26 PM
>>
>>> It turns out that Nischala Yelchuri at Microsoft is
>>> concurrently working on fixing this occurrence as well as the
>>> others we know about in Hyper-V specific code.
>>
>> So should I continue or not with this patch?
>>
> 
> I'll suggest deferring to Nischala's pending patch.  Her patch
> covers all 5 occurrences.  Also, I don't know if you were able
> to test your patch in a Hyper-V Confidential VM.  She did test
> in that configuration and confirmed that nothing broke.
> 
> Of course, feel free to correspond directly with Nischala
> on how best to move forward.  I'm an unnecessary intermediary
> who is just pointing out the overlap. :-)
> 
> Michael

Okay will ask her about the patch.
Thank you for your time to review and guide me :)


Abhinav

