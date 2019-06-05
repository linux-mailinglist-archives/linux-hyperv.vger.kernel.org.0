Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EC436439
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFETKY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:10:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40506 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfFETKX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:10:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so15396681pfn.7
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Jun 2019 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECON+3GqS4gPhtd0pv7FErM7REhB/G/cWUwMq48vsuw=;
        b=jish6J8M/xP0Fp6UOlEa+Ly3bbYcg/Q/GGmqjPbTE+LnbRn8KO2KjMTEQGktrU3Y2m
         fHXFGMy6x4fkSawSJKjjvqoZ4AMdUoWZboAeeGPuer2ukfjUSSvaWsUQf7fRk0KEhH8E
         L2gaedIJ8fDffWKAqLQgeD9/l2I2RJJRCOAbDM2Ro58QwOWXASbCn6PlyFDzsBahC6kA
         mRU7YkayEy+tqNIIi+J5osjuxSI6l5pFy9yH7/2goJkrnjWmW4fMCfmFdL7eqgNqFpiw
         OVKD61ZBQoQE6+qDtOO1GrUZ+/uPugM920SFXc/t1/fn/DmWBVVTUKlMuRt4etA1PR7U
         AiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECON+3GqS4gPhtd0pv7FErM7REhB/G/cWUwMq48vsuw=;
        b=CJaiQPz43Cn+qjvT+A4g2y7J8Hobgvpx+yY75UvmxbBS6zqbg5WTHG8mHRCZ98Vkrt
         TP1v1SLm9zUIeWGyPzKrUTstfPUcUDtXvY54Xso2rSiF4vgUsentIrMuKjd7n67BtTsV
         ZnnCCh17eyUXPg9dmDTGD9LeLZkAwQsXC/RfouSfWA87ZEhuEqncut5U+xMI/upXDyOM
         +AcEoKCSxBaKpck6rik3I45yU+6u88oG/RF8DxOjXNM62c8p6j3EqYiDuC8qJ6HTkfjr
         uS9bhtiHHi8VPj+l74kMr+KYsiSIFxYGhjDuhoTPYtSw1PSM9KBhRIywni/HFee4ja1z
         Xcjw==
X-Gm-Message-State: APjAAAWNx/wRz4vgGWX+VGXidoj3BsoH5bUv5aAjPvxZgSUmZniiZNVP
        WM3XKGl7qKK0fP5FZoEeSdwwVA==
X-Google-Smtp-Source: APXvYqye5sLFtUV5ShpAXZlEr0EuAV0uNSE4iugyD42OUt69HRIWpRIXqGtLvlM3f2RxFe5+Aa1FUA==
X-Received: by 2002:a63:5b5c:: with SMTP id l28mr365033pgm.158.1559761822336;
        Wed, 05 Jun 2019 12:10:22 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id x1sm18065098pgq.13.2019.06.05.12.10.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 12:10:22 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:10:20 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605121020.1a41b753@hermes.lan>
In-Reply-To: <20190605190722.GA19684@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
        <20190605185637.GA31439@infradead.org>
        <20190605120640.00358689@hermes.lan>
        <20190605190722.GA19684@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 5 Jun 2019 12:07:23 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jun 05, 2019 at 12:06:40PM -0700, Stephen Hemminger wrote:
> > > Which is true for every device, and why we use UUIDs or label for
> > > mounts that are supposed to be stable.  
> > 
> > Not everyone is smart enough to do that.  
> 
> Sure.  But they should not get a way out for just one specific driver.

There are people running new kernels on 6 year old distributions.
Was every distribution smart enough then? If you think so, then
this not necessary.
