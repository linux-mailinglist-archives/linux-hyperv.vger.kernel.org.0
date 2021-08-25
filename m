Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762303F7C82
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Aug 2021 21:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhHYTDH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Aug 2021 15:03:07 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35346 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhHYTDG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Aug 2021 15:03:06 -0400
Received: by mail-wr1-f47.google.com with SMTP id i6so831165wrv.2;
        Wed, 25 Aug 2021 12:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7BdpJPLxYArrEdxYe++f+NxY9LUgjM31XxS12NOjYCU=;
        b=VFSFLWevtQ23xV7zUHTzTZE3nCKpLjIwelgivyjOkaV63myc9/Q+A1whyg/qYx8wjy
         RgiIy6EF6Wkm668xpiLs5gseAqYakygu+Qt1y8/zRBxTD8Q1fabxw1ZmPDZinsXU8ZWj
         tWfuwMgQt+BgUDop2m5R1YVCVHKaRZHjOLxFu4R1YvAtw0kSpxv1BPDwQJJ3oBl6ti14
         MXcPZRJ8NHC3YGBMNXx6f0Oqnob5E5lb/IKfBwqn9HZiFxknKMC4wMouGCb4LxfhPFNx
         x3q+Q504nCLYjepZyLtYqgw8q4y5RwsfFnvyWgBEeJB76u5rYNUmROjixNsy7fIOukLw
         uZVA==
X-Gm-Message-State: AOAM530LmN/KYaRsGFQsMvJjfpxzMGAZ5QC9zkj7KZrVgsIzc249Y9bV
        0vpOkqRiHMKFwofCFdag46k=
X-Google-Smtp-Source: ABdhPJyahFAdIe01WapJbPLJVuieahn/QaaQ0GS9ZXcK2LwxdznS2WnUW63IuYgWs5jEQ9NWA8fF0A==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr27089548wrw.341.1629918139985;
        Wed, 25 Aug 2021 12:02:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b13sm643974wrf.86.2021.08.25.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 12:02:19 -0700 (PDT)
Date:   Wed, 25 Aug 2021 19:02:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andres Beltran <lkmlabelt@gmail.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hv_utils: Set the maximum packet size for VSS driver to
 the length of the receive buffer
Message-ID: <20210825190217.qh2c6yq5qr3ntum5@liuwe-devbox-debian-v2>
References: <20210825133857.847866-1-vkuznets@redhat.com>
 <MWHPR21MB15931C94B84D62C451163BAFD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15931C94B84D62C451163BAFD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 25, 2021 at 06:33:10PM +0000, Michael Kelley wrote:
> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Wednesday, August 25, 2021 6:39 AM
> > 
> > Commit adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out
> > of the ring buffer") introduced a notion of maximum packet size and for
> > KVM and FCOPY drivers set it to the length of the receive buffer. VSS
> > driver wasn't updated, this means that the maximum packet size is now
> > VMBUS_DEFAULT_MAX_PKT_SIZE (4k). Apparently, this is not enough. I'm
> > observing a packet of 6304 bytes which is being truncated to 4096. When
> > VSS driver tries to read next packet from ring buffer it starts from the
> > wrong offset and receives garbage.
> > 
> > Set the maximum packet size to 'HV_HYP_PAGE_SIZE * 2' in VSS driver. This
> > matches the length of the receive buffer and is in line with other utils
> > drivers.
> > 
> > Fixes: adae1e931acd ("Drivers: hv: vmbus: Copy packets sent by Hyper-V out of the ring buffer")
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Given we're really close to the merge window I'm going to apply this to
hyperv-next.

Wei.
