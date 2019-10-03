Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BEACAE19
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2019 20:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbfJCSXC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 14:23:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35364 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731438AbfJCSXC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 14:23:02 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so7867818iop.2;
        Thu, 03 Oct 2019 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4hW9F/rndnpcOOaucgLoBVdnGt4rBKKWToBojv2TwQ8=;
        b=g5GX7ssQedVGoeidnbB19TwJyrGbYyrQ56f71dNBu0A8OcrSjhuRxGSKqZYDyobJQQ
         ms4T4MldIgPmuEPzJKrKYjWMAOiTqSF/UesGGUKHF7chB0LdxZitzssq8zg/VwkNVSs9
         jdVAbPe4Usvfz1W6Hke24nOMgUtcQvY7W9bFxeO/9fjSrnn7uiqh0fbgYRf5fTWXnptX
         CGs79TDP7nO7iIiic/jjfJQ91iIhOczg1XCWRxxI6YxVbcYkRqi0bK4HLJTix/CL/8bV
         CAbtoVMreqkOnYA6ArvTDm+jIJPcZMt/WgLbb3LYTlwldTwkxqd/kyVZP/JocvV65kzI
         f42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4hW9F/rndnpcOOaucgLoBVdnGt4rBKKWToBojv2TwQ8=;
        b=BzXe2K/TVcu66yvADNmRDvHVR92mkgciDlM68OxpI3Gs/AoCYoz7SmYb6nPBoUHJBf
         acD0Pezw6+JHOV6bEchwqWli1BviUx9wbUO6o3N/anXVzRkhLag29SlwyS22tzFelHhf
         1ZR/jDdu+b8bF+neq2ec0bhhzEuVnYlclOWGKBfhzFQ+Tw6MxW0mvXr3SA6CpUnV9+3X
         +8Ot9mzyfjuu1nO2BPm+dvN4sBY2pDWxhHIQpmknNE9QkWoGUUE2HbWerJSQpq4XyMaR
         K9+1pVpYkqj+l3demndogze/1IT5ntRtdfETss7ymRPrx0cSaCFiWwNw00IX6vHypQsF
         jgHQ==
X-Gm-Message-State: APjAAAU1mYbfxLlI979h+VZHtz/bKuxds7P4fYGePr6ZdDZpgiStrDoR
        J2gL1FnGeEFMyAxMSxkfeA==
X-Google-Smtp-Source: APXvYqxEQ16JuFvRHP8l8h43Cr24aZkiqnUek1B6jbdlUSI62W5tom2z7Ji3+QqgSP/Su/9ZFAUIjQ==
X-Received: by 2002:a6b:b88a:: with SMTP id i132mr8947932iof.215.1570126981182;
        Thu, 03 Oct 2019 11:23:01 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id u124sm1287165ioe.63.2019.10.03.11.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 11:22:59 -0700 (PDT)
Date:   Thu, 3 Oct 2019 14:22:56 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] drivers: hv: vmbus: Introduce latency testing
Message-ID: <20191003182256.GA8951@Test-Virtual-Machine>
References: <cover.1568320416.git.brandonbonaby94@gmail.com>
 <83b5fc34e8f25c882f2502931f766ef547c6c950.1568320416.git.brandonbonaby94@gmail.com>
 <DM5PR21MB01373C2DB4DE6A4B6079C2BAD7890@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR21MB01373C2DB4DE6A4B6079C2BAD7890@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Sep 19, 2019 at 10:52:41PM +0000, Michael Kelley wrote:
> From: Branden Bonaby <brandonbonaby94@gmail.com> Sent: Thursday, September 12, 2019 7:32 PM
> > 
> > +
> > +static int hv_debugfs_delay_set(void *data, u64 val)
> > +{
> > +	int ret = 0;
> > +
> > +	if (val >= 0 && val <= 1000)
> > +		*(u32 *)data = val;
> > +	else
> > +		ret = -EINVAL;
> > +
> > +	return ret;
> > +}
> 
> I should probably quit picking at your code, but I'm going to
> do it one more time. :-)
> 
> The above test for val >=0 is redundant as 'val' is declared
> as 'u64'.  As an unsigned value, it will always be >= 0.  More
> broadly, the above function could be written as follows
> with no loss of clarity.  This accomplishes the same thing in
> only 4 lines of code instead of 6, and the main execution path
> is in the sequential execution flow, not in an 'if' statement.
> 
> {
> 	if (val > 1000)
> 		return -EINVAL;
> 	*(u32 *)data = val;
> 	return 0;
> }
> 
> Your code is correct as written, so this is arguably more a
> matter of style, but Linux generally likes to do things clearly
> and compactly with no extra motion.
> 

Yea the less than 0 comparison isnt needed, so I'll update that

> +/* Delay buffer/message reads on a vmbus channel */
> > +void hv_debug_delay_test(struct vmbus_channel *channel, enum delay delay_type)
> > +{
> > +	struct vmbus_channel *test_channel =    channel->primary_channel ?
> > +						channel->primary_channel :
> > +						channel;
> > +	bool state = test_channel->fuzz_testing_state;
> > +
> > +	if (state) {
> > +		if (delay_type == 0)
> > +			udelay(test_channel->fuzz_testing_interrupt_delay);
> > +		else
> > +			udelay(test_channel->fuzz_testing_message_delay);
> 
> This 'if/else' statement got me thinking.  You have an enum declared below
> that lists the two options -- INTERRUPT_DELAY or MESSAGE_DELAY.  The
> implication is that we might add more options in the future.  But the
> above 'if/else' statement isn't really set up to easily add more options, and
> the individual fields for fuzz_testing_interrupt_delay and
> fuzz_testing_message_delay mean adding more branches to the 'if/else'
> statement whenever a new DELAY type is added to the enum.   And the
> same is true when adding the entries into debugfs.  A more general
> solution might use arrays and loops, and treat the enum value as an
> index into an array of delay values.  Extending to add another delay type
> could be as easy as adding another entry to the enum declaration.
> 
> The current code is for the case where n=2 (i.e., two different delay
> types), and as such probably doesn't warrant the full index/looping
> treatment.  But in the future, if we add additional delay types, we'll
> probably revise the code to do the index/looping approach.
> 
> So to be clear, at this point I'm not asking you to change the existing
> code.  My comments are more of an observation and something to
> think about in the future.
> 

I do see your point, thanks for the input. I think since its just two
it might be better to leave it but it definitely makes sense.

> > 
> > +enum delay {
> > +	INTERRUPT_DELAY = 0,
> > +	MESSAGE_DELAY   = 1,
> > +};
> > +
> 
> Michael
