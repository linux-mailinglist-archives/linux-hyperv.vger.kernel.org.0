Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB4447F49
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Nov 2021 13:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbhKHMLb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Nov 2021 07:11:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58306 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239396AbhKHMLa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Nov 2021 07:11:30 -0500
Received: from zn.tnic (p200300ec2f331100bbe06604d19d6498.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:bbe0:6604:d19d:6498])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C5F91EC036B;
        Mon,  8 Nov 2021 13:08:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636373323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IkJ+y15zqfXIITO4Nl7mRfhUkJXCopTzX4p21tGzC+o=;
        b=HRd6Nzdf4oV0tEUheAEC837pzKtFei0cZ4Eq3eAviZxrnaJRpZqHG/CEAZzDQH/n6t9NE1
        Cl8ns/oFAb+1GVimzwBjsGOVQQ2x9OFe9eZCN/MBHeGWvo9Y4RQPe0ZVvzvtrntxR3ZarW
        cm+6bEEOz+RGxe5wuN9m4dasBBtlI9U=
Date:   Mon, 8 Nov 2021 13:08:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v0 08/42] Drivers: hv: vmbus: Check notifier registration
 return value
Message-ID: <YYkTRdv2AtRXoiUi@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-9-bp@alien8.de>
 <20211108111637.c3vsesezc7hwjbty@liuwe-devbox-debian-v2>
 <YYkMYtYkvwiyzGNG@zn.tnic>
 <20211108114549.q3lkgjwm5d7tkbcp@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211108114549.q3lkgjwm5d7tkbcp@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 08, 2021 at 11:45:49AM +0000, Wei Liu wrote:
> Yes please take them through tip. I should've been clearer on this.
> Sorry.

No worries - I'll do so.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
