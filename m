Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5014A989E2
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 05:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfHVDgN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Aug 2019 23:36:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36151 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHVDgM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Aug 2019 23:36:12 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so9079206iom.3;
        Wed, 21 Aug 2019 20:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wl7Cl9P4ljL83LEC/VDtQhra4RC/CXvX5bYJJK5SHmI=;
        b=Y1FjN65VZ6whH3eKmvSi6fAh815HQE++NXMef+ora2Dnh9pdeRp9FLuBeiWgwp6tzw
         29g+UC5qbWF3KXY3eGObaSf2uEO17DbDlGTI6gacfOSLKnTQ24oEaeuJvR6LhtmsUQAn
         VTlH3FN+ebsbTtO0tLQKG0BXeSUyV+EKvIk0iptC8AIf8vlPf5lAgHM48YiiSI5yWQFt
         ZWO8cUa0h/Ul6vf6saqQEP3dZR3ly15T161i/Vfw3WtXRcvx67HjJsaQHFYMPP4qAIEQ
         QGLHsvfRQ4b1AMv+4p80/BxZcAM+bUN3i4092+/n6oFeBVdEUYVRV1KR1I5zVkNN7kAk
         MNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wl7Cl9P4ljL83LEC/VDtQhra4RC/CXvX5bYJJK5SHmI=;
        b=Uq2tqsxkm9lRYG0GeW5jG1Bi5AQosi9riPJ4596IkL/64AgOneDPhNrjRq5Hz0PN52
         bVBGuLcEEZFGVJlSTkI1oQDNGD/xfWHg6Xzpn8aqMfanjLG98/gH5OBDAvGR/X0H/Tjt
         e5wrHLMucagQp1uLDo+fL9iaJu5BtXJye7TYpJ39mhRTL4wuInKDEVxWrLUPLKAeyti0
         9T5OYa3GZTjtkHSYR+5GrRU6Z/JQsKfY6MjknyS0yQuPYzsWjvoMJCUGVOeWD/Q9jwSY
         Qytj899HEDNI25nXpj/ek2VR6dVJ5Zq8RtWhsy5UmYZNMBsOVCu0U8JRrBSBN2EU0Oo/
         4HOg==
X-Gm-Message-State: APjAAAVq1er7ymf2sWEOmz3uZKcVp1avqSLeVg4yPGz1gu6nX/LEfqxU
        rQziQnEq8h6xsVxEJcjsQg==
X-Google-Smtp-Source: APXvYqxEJ2XCHWvZF+u55HDjvMHUUPAUd8NXrrTBVREvcd66T38l7WLAOYRwTZM+H28ZTUUi9C+qOw==
X-Received: by 2002:a05:6602:2298:: with SMTP id d24mr1187213iod.167.1566444972054;
        Wed, 21 Aug 2019 20:36:12 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id e12sm43671558iob.66.2019.08.21.20.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 20:36:11 -0700 (PDT)
Date:   Wed, 21 Aug 2019 23:36:09 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] drivers: hv: vmbus: add test attributes to debugfs
Message-ID: <20190822033609.GB37262@Test-Virtual-Machine>
References: <cover.1566340843.git.brandonbonaby94@gmail.com>
 <a17474c59601a98576f1e002a57192f6314b4aaf.1566340843.git.brandonbonaby94@gmail.com>
 <DM5PR21MB0137B4071E64688C5F902E83D7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR21MB0137B4071E64688C5F902E83D7AA0@DM5PR21MB0137.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > +What:           /sys/kernel/debug/hyperv/<UUID>/fuzz_test_state
> > +Date:           August 2019
> > +KernelVersion:  5.3
> > +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> > +Description:    Fuzz testing status of a vmbus device, whether its in an ON
> > +                state or a OFF state
> 
> Document what values are actually returned?  
> 
> > +Users:          Debugging tools
> > +
> > +What:           /sys/kernel/debug/hyperv/<UUID>/delay/fuzz_test_buffer_interrupt_delay
> > +Date:           August 2019
> > +KernelVersion:  5.3
> > +Contact:        Branden Bonaby <brandonbonaby94@gmail.com>
> > +Description:    Fuzz testing buffer delay value between 0 - 1000
> 
> It would be helpful to document the units -- I think this is 0 to 1000
> microseconds.

you're right, that makes sense I'll add that information in. Also 
to confirm, it is microseconds like you said.

> > +static int hv_debugfs_delay_set(void *data, u64 val)
> > +{
> > +	if (val >= 1 && val <= 1000)
> > +		*(u32 *)data = val;
> > +	/*Best to not use else statement here since we want
> > +	 * the delay to remain the same if val > 1000
> > +	 */
> 
> The standard multi-line comment style would be:
> 
> 	/*
> 	 * Best to not use else statement here since we want
> 	 * the delay to remain the same if val > 1000
> 	 */
>

will change

> > +	else if (val <= 0)
> > +		*(u32 *)data = 0;
> 
> You could consider returning an error for an invalid
> value (< 0, or > 1000).
> 

its subtle but it does make sense and shows anyone
reading that the only acceptable values in the 
function are 0 <= 1000 at a glance. I'll add
that in.

