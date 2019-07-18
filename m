Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8FF6CA64
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jul 2019 09:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfGRH4Z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jul 2019 03:56:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56468 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfGRH4Z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jul 2019 03:56:25 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ho1H0-0002PL-4u; Thu, 18 Jul 2019 09:56:18 +0200
Date:   Thu, 18 Jul 2019 09:56:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dexuan Cui <decui@microsoft.com>
cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH] x86/hyper-v: Zero out the VP assist page to fix CPU
 offlining
In-Reply-To: <PU1P153MB0169BE20761D77E7FD9A3D57BFC80@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Message-ID: <alpine.DEB.2.21.1907180955130.1778@nanos.tec.linutronix.de>
References: <PU1P153MB01697CBE66649B4BA91D8B48BFFA0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM> <alpine.DEB.2.21.1907180058210.1778@nanos.tec.linutronix.de> <PU1P153MB01693AB444C4A432FBA2507BBFC80@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <alpine.DEB.2.21.1907180846290.1778@nanos.tec.linutronix.de> <PU1P153MB0169BE20761D77E7FD9A3D57BFC80@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 18 Jul 2019, Dexuan Cui wrote:
> 
> The concept of the "overlay page" seems weird, and frankly speaking, 
> I don't really understand why the Hyper-V guys invented it, but as far
> as this patch here is concerned, I think the patch is safe and it can
> indeed fix the CPU offlining issue I described.

Then this needs some really good explanation and in the change log because
that's really obscure behaviour.

Thanks,

	tglx
