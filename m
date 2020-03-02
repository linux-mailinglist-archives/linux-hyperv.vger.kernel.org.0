Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3838B175A0C
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Mar 2020 13:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCBMJ5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Mar 2020 07:09:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38315 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCBMJ4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Mar 2020 07:09:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id u9so4552169wml.3;
        Mon, 02 Mar 2020 04:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HIdRpR70+QiBon8Ma1Xnuin2v9Xkjqqh4sLfhR88VOM=;
        b=jdWX0w1jICgaYAyYG/vju/waqVq+LoN0pr44AVHZrMFPPzKpNzJNdHWWBtLe4mF0Gi
         AqyOaeDaSjR4JRPsW2nGCeBp8ldrTs9EwqQtQMUZT5tji+HBgNgFOZOic7rY2kh3uuRW
         gI+qzVEGnW2Ik7mWmfgX1z9+B11DO2P5OMNDKVIwy87pTY5WxCQMsb54dzorclHSWFmi
         ZqVOK/gbQ9mtMVBx34hPwRoK6cLmc2Ehi8lbnL4Qmb1OXbi4pZCDQ5bXhTHs60v146Jq
         w0Wyj+eHv/en7HLZAGB2g2TnbGxYpCXqKZ0fsLc/LjVZv4eYoHIFLgLaL85ZisdWmoJV
         XLOg==
X-Gm-Message-State: APjAAAV+mhnDep4B2m6HDkhwDsCQnnLRG8QocLKMc4arr1qM3zm22VuB
        8UJ/9mQow6PlMpTuKAbFucCdsEBe
X-Google-Smtp-Source: APXvYqzS6jA4Bf74WoSBtBQEM9gCfI3J+KLYf70fc37trFR2aHCaU3D+9BVxUEA+UPJd1Taywlmzvw==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr15031793wmj.41.1583150994648;
        Mon, 02 Mar 2020 04:09:54 -0800 (PST)
Received: from debian (41.142.6.51.dyn.plus.net. [51.6.142.41])
        by smtp.gmail.com with ESMTPSA id h14sm10765190wrs.85.2020.03.02.04.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:09:53 -0800 (PST)
Date:   Mon, 2 Mar 2020 12:09:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Lucas Tanure <tanure@linux.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, linux-hyperv@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] HID: hyperv: NULL check before some freeing functions is
 not needed.
Message-ID: <20200302120951.fhdafzl5xtnmjrls@debian>
References: <20200229173007.61838-1-tanure@linux.com>
 <CAO-hwJJDv=LnOQDbgWwg2sOccM9Tt-h=082Coi0aYdwG-CG-Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJJDv=LnOQDbgWwg2sOccM9Tt-h=082Coi0aYdwG-CG-Kg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Benjamin

On Mon, Mar 02, 2020 at 11:16:30AM +0100, Benjamin Tissoires wrote:
> On Sat, Feb 29, 2020 at 6:30 PM Lucas Tanure <tanure@linux.com> wrote:
> >
> > Fix below warnings reported by coccicheck:
> > drivers/hid/hid-hyperv.c:197:2-7: WARNING: NULL check before some freeing functions is not needed.
> > drivers/hid/hid-hyperv.c:211:2-7: WARNING: NULL check before some freeing functions is not needed.
> >
> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > ---
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Sasha, do you prefer taking this through your tree or through the HID
> one. I don't think we have much scheduled for hyperv, so it's up to
> you.

Sasha stepped down as a hyperv maintainer a few days back. I will be
taking over maintenance of the hyperv tree.

The problem is at the moment I haven't got write access to the
repository hosted on git.kernel.org. That's something I will need to
sort out as soon as possible.

In the meantime, it would be great if you can pick up this patch so that
it doesn't get lost while I sort out access on my side.

Thanks,
Wei.
