Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADAECAD8A
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2019 19:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfJCRpg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Oct 2019 13:45:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37449 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730530AbfJCRpg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Oct 2019 13:45:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so2226517pfo.4;
        Thu, 03 Oct 2019 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cTaX338E0Xi7tlWl150QisR1sVTVGkEbaKzGC+/ciNs=;
        b=QQcAnwxF76LQ1iEdNrNWVvOLiJ3Pv9O/72dUcsxjGOQigOb5iuS9UbQ7rLfUwzX/gJ
         jqBErtxrGhgaZLQE6p4fAEypMdxCOl9NmDvsjra8+YCjZ9Cr1uIn2Z2i/upxhdCIoGuI
         VT+tSQPPqcmRTKABq3cWVni37mU57j9Dc2jULLNkIMxitydg5/pSiHALAeYx3eDfESvl
         bCEttP6mG3DRJ+bY2mF/pIUSSZW3c/nWGer7SkCNfqOGkB5381hD1j1MbHzeKB3FKTi8
         pR6Z3UvBLJWEMvU/VJCiiK3Rkr1RZqOWbRCVJH7E+OOwQFQ8JcjVv9jOINXvEsAMJw4i
         pkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cTaX338E0Xi7tlWl150QisR1sVTVGkEbaKzGC+/ciNs=;
        b=cC55GZ7dHncJe5qdRJdsHC/v1HWw7YtFe6fv+mzdS50Is0/Vs5HkKDtVRgo0CJPHja
         tCLZJiCjyYmd7DVeOI5JdvGEOLkyFPG84s+gj2jZIpRAJqESoHdCELeR6kvS/wAMkHEU
         9g29EPpwcmFHf0WYJa837f9DaGQLHbIo1arG9uR1cDFI7DZEyeCi+jqgbmqHBpiR4vks
         d57idsNkHOA5LQ24x7nFS3O5VjfUDXHIbmO/x1mqQP9mYN+LiUW2yMlKTa4pzLg6benX
         bUWp32Ee7d3U9X03mbcgsueDznv7oKcZFfyT5KcBAyDdEH5K1MxKM8UPkmC3yeplAKmF
         x49w==
X-Gm-Message-State: APjAAAVxh9sPCGgGZa9Uxgft2C7geoUZmKVhaBJ235PUh7KI/AQeQWIo
        9aiP3KKCjr83xxkZMiailG0=
X-Google-Smtp-Source: APXvYqyhfSmDaD5ho1JbN3LelcUweH4EA3Q2Q7tRjR4/lz4xS/Ll4Y4s4rLKfFgDVHeBDFpoz1hf7Q==
X-Received: by 2002:a17:90a:be08:: with SMTP id a8mr11998250pjs.92.1570124733826;
        Thu, 03 Oct 2019 10:45:33 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 7sm2799565pgj.35.2019.10.03.10.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 10:45:32 -0700 (PDT)
Date:   Thu, 3 Oct 2019 10:45:30 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] Input: hyperv-keyboard: Add the support of hibernation
Message-ID: <20191003174530.GB22365@dtor-ws>
References: <1568244975-66795-1-git-send-email-decui@microsoft.com>
 <20190919161752.GS237523@dtor-ws>
 <PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190928003156.GU237523@dtor-ws>
 <PU1P153MB0169C315F7F9EBEBED4C7A7DBF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190930230652.GW237523@dtor-ws>
 <PU1P153MB01696258D9983DF59D68E748BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169CC57749BF297F2581B02BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PU1P153MB0169CC57749BF297F2581B02BF9F0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 03, 2019 at 06:44:04AM +0000, Dexuan Cui wrote:
> > From: Dexuan Cui
> > Sent: Wednesday, October 2, 2019 10:35 PM
> > > ... 
> > >
> > > ¯\_(ツ)_/¯ If you do not want to implement hibernation properly in vmbus
> > > code that is totally up to you (have you read in pm.h how freeze() is
> > > different from suspend()?).
> > > Dmitry
> > 
> > I understand freeze() is different from suspend(). Here I treat suspend() as a
> > heavyweight freeze() for simplicity and IMHO the extra cost of time is
> > neglectable considering the long hibernation process, which can take
> > 5~10+ seconds.
> > 
> > Even if I implement all the pm ops, IMO the issue we're talking about
> > (i.e. the hibernation process can be aborted by user's keyboard/mouse
> > activities) still exists. Actually I think a physical Linux machine should have
> > the same issue.
> > 
> > In practice, IMO the issue is not a big concern, as the VM usually runs in
> > a remote data center, and the user has no access to the VM's
> > keyboard/mouse. :-)
> > 
> > I hope I understood your comments. I'll post a v2 without the notifier.
> > Please Ack the v2 if it looks good to you.
> > 
> > -- Dexuan
> 
> I think I understood now: it looks the vmbus driver should implement
> a prepare() or freeze(), which calls the hyperv_keyboard driver's
> prepare() or freeze(), which can set the flag or disable the keyboard
> event handling. This way we don't need the notifier.

Right. I think in practice the current suspend implementation can work
as freeze() for the HV keyboard, because in suspend you shut off vmbus
channel, so there should not be wakeup signals anymore. What you do not
want is to have the current resume to be used in place of thaw(), as
there you re-enable the vmbus channel and resume sending wakeup requests
as you are writing out the hibernation image to storage.

I think if vmbus allowed HV keyboard driver to supply empty thaw() and
poweroff() implementations, while using suspend() as freeze() and
resume() as restore(), it would solve the issue for you.

Thanks.

-- 
Dmitry
