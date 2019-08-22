Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D4989C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 05:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfHVDQf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 23:16:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44218 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHVDQf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 23:16:35 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so655782iog.11;
        Wed, 21 Aug 2019 20:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TtertmLvNhD994TQ2dS81rm18H0RxAIy1U/i+r1aP8c=;
        b=fVn+IM8YO9kCNczHLi2YD/XfNxmhEf2UsVUOkmv4WYU8hT1mAb+2WclAcCAtXXAT69
         uOW4AkayV4i+WXYIrra32kM+WRlTpOmvNOqQqHKl/haoonOyxCpomBLzuE1+eROW8XbT
         srfKPnbYJS6DIz4M9psKQSJWlm3/SGmIU8wxw3yt+VAe/jG/cYhMkjvkVVowKIV4WBFX
         WR2u/ja18MW73HyyNrP5+3OH1wz4Vvm2Zr82n+CggKaRQBQZS0FWynYy/wiT+2s1hIAs
         ncuuL2/9p9waVgTPz4ycytEaTAdZTlGjVxEAu5Njw0OejAtaBmII079XLkcazxrbe7YM
         Hgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TtertmLvNhD994TQ2dS81rm18H0RxAIy1U/i+r1aP8c=;
        b=Lvt5gG06m6VCSvgEpiFbixDKuVjSWNI2cWvozxvsmfmbU9JogwRoaFbRMGknlsSrWe
         JqhKhwHGNuTb2fesqYbFWeZsckZS2yiblRZO3Z6rUsNrByTaMMBtxylcVhcOC+ac/SUT
         iwkc6mxkl/DNn6EhIk3DMLu2NFbdYhz9IF8IM/BwByKlgghW6LGPqwROCNmmehCQaZik
         hq0bzzdGlEjRoEwieTXNOjHmJuFTQPlQ7BjIjiJMSwLZ82lD8qdNZaolLRS2VPLB8c/3
         u4KH1xgWo2M2/uxOY0snEouNrdJhVvf8LTFMWaBiFCz6fC6MD7FmvQcke9zU2NN1LnlR
         yZTg==
X-Gm-Message-State: APjAAAUyamKSXkAbd6r3OO+2VXB9zWKwJ40npz97XtoN282DSIQhDCte
        bWdxKC8ZE9wiXpC0VX3g0g==
X-Google-Smtp-Source: APXvYqziqhmkvV2PqA2POT4i7S3BQ4r8ivWZ0xA2khR9WBcWupbZZMTRTn+Gs2DRZBoSW5YMKVO9gQ==
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr7951406iob.271.1566443794786;
        Wed, 21 Aug 2019 20:16:34 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id 8sm19911023ion.26.2019.08.21.20.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 20:16:32 -0700 (PDT)
Date:   Wed, 21 Aug 2019 23:16:30 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Harry Zhang <harz@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] tools: hv: add vmbus testing tool
Message-ID: <20190822031630.GA37262@Test-Virtual-Machine>
References: <cover.1566340843.git.brandonbonaby94@gmail.com>
 <c63cae8e916cbfa4a3fe627da3a545736d0b45dc.1566340843.git.brandonbonaby94@gmail.com>
 <PS1P15301MB02497E19A17D71913DA32857C0A50@PS1P15301MB0249.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1P15301MB02497E19A17D71913DA32857C0A50@PS1P15301MB0249.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 22, 2019 at 01:36:09AM +0000, Harry Zhang wrote:
> Tool function issues:  Please validate args errors for  '-p' and '--path',  in or following validate_args_path().  
> 
> Comments of functionality:
> -	it's confusing when fuzz_testing are all OFF, then user run ' python3 /home/lisa/vmbus_testing -p /sys/kernel/debug/hyperv/000d3a6e-4548-000d-3a6e-4548000d3a6e delay -d 0 0 -D ' which will enable all delay testing state ('Y' in state files).  even I used "-D", "--dis_all" param. 
> -	if we have subparsers of "disable-all" for the testing tool, then probably we don't need the mutually_exclusive_group under subparsers of "delay"
> -	the path argument (-p) could be an argument for subparsers of "delay" and "view" only.
> 
> Regards,
> Harry
>

So I made the choice to keep disabling the state and disabling delay
testing seperate, because once we start adding other testing options
you wouldn't want to inadvertently disable all testing especially
if you were doing more than one type of test at a time.
So with your configuration

'python3 /home/lisa/vmbus_testing -p /sys/kernel/debug/hyperv/000d3a6e-4548-000d-3a6e-4548000d3a6e delay -d 0 0 -D '

this would stop all delay testing on all the devices but wouldn't change
their test state to OFF 'N'.So thats why I have the option -s --state to
change the state to Off with a -s 0. Then to disable all types of testing
and change the state to OFF thats where the 'disable-all' subparser  comes in.
with:

'python3 /home/lisa/vmbus_testing disable-all

For that last point I don't understand what you mean, are you saying it would be
better to have something like this using  delay as an example?

'python3 /home/lisa/vmbus_testing delay -p /sys/kernel/debug/hyperv/000d3a6e-4548-000d-3a6e-4548000d3a6e'

If thats what you mean I figured it was better to make the -p accessible
to all test type so I made it apart of the main parser. This would allow
us to just have it there once instead of having to make a -p for every
subparser.

Also maybe I need to change the examples and the help text
because with the -D option for delay you wouldnt actually need to put in 
the path. As

'python3 /home/lisa/vmbus_testing delay -d 0 0 -D '

would suffice to stop delay testing on all devices; -E would enable
it for all devices and change the state to On 'Y' if it wasn't already.

let me know your thoughts

branden bonaby
