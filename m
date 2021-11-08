Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619F6447F08
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Nov 2021 12:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhKHLmJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Nov 2021 06:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhKHLmG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Nov 2021 06:42:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05D5C061570;
        Mon,  8 Nov 2021 03:39:22 -0800 (PST)
Received: from zn.tnic (p200300ec2f331100bbe06604d19d6498.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:bbe0:6604:d19d:6498])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EFE771EC04DE;
        Mon,  8 Nov 2021 12:39:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636371560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fMAol2repudDd8TXhSVhZtfjNlX2LrvJk6WKpVinc98=;
        b=rzZPwl7NZ0JXIABqnksvr15gvAtfWCnWpo/TAAbAG7Qv0mWui0aIIwG0va18r8K+TTUWQP
        /onZ8Z6tOtLyxlidhu+hgFAwuB844fr776QTedz4Py1KFbGPMhVkvJ+QVzFCUy6VEJJbiv
        VBKtCtSbWKW8YtyFMtH1tgcgmfAWths=
Date:   Mon, 8 Nov 2021 12:39:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v0 08/42] Drivers: hv: vmbus: Check notifier registration
 return value
Message-ID: <YYkMYtYkvwiyzGNG@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-9-bp@alien8.de>
 <20211108111637.c3vsesezc7hwjbty@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211108111637.c3vsesezc7hwjbty@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Nov 08, 2021 at 11:16:37AM +0000, Wei Liu wrote:
> On Mon, Nov 08, 2021 at 11:11:23AM +0100, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Avoid homegrown notifier registration checks.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: linux-hyperv@vger.kernel.org
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>

Thanks.

I assume your ack means, I can take the two through tip.

Alternatively, you can take 'em too, if you prefer, as there's no
dependency, see here:

https://lore.kernel.org/r/20211108101924.15759-1-bp@alien8.de

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
