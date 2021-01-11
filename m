Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13182F10D0
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jan 2021 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbhAKLGl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jan 2021 06:06:41 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36506 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbhAKLGl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jan 2021 06:06:41 -0500
Received: by mail-wm1-f42.google.com with SMTP id y23so14644687wmi.1;
        Mon, 11 Jan 2021 03:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tpCjrqa5CVCjTtdyszt7E01t6dI8BxCUY3VyFYIKnzc=;
        b=E14cCJGAKR0VVAf/nueRrqofxn8HM4EXDvXIpdwyeiBTqZhLO/hdfy6SOWrPtc8sci
         6lNM5fTfnZh/GsslwsyJEb+KNP1I7XHG9s5aflsS6D80ZFE96rdjVpaFkj95lkk93IpN
         WCnbdaqd6WhwDjw/TjaxUWEjr0SIf9xjPshlesJOKSTj1/evwdsg3rIakYd1arAhPO7E
         tMkhk+K2P71D+vyFe6htbamw86H8ZDNUWqaLdgSAwogggETVydSNbSRVyZV0LAJfcDbY
         vNTtFPiFABjntDd7ceplRWS/cMvGOpGCzUvDpwbiybjwDL9VOVoW5TUz9lj7+GbCfvMN
         EyBA==
X-Gm-Message-State: AOAM533lPpsAKq1ACMNx5cWYW6Z9uZSnFE9qSqCIfABEmbnlOV6u4e7o
        O9EncJX2jE4iSlnbifXljOY=
X-Google-Smtp-Source: ABdhPJwi2PYZZHP8Chl2DszucgzD2i5NNS1Hc4Mm5HeX+ZGszieBgyupe4bqqXE+jBb6zFAyc+iyYg==
X-Received: by 2002:a1c:3206:: with SMTP id y6mr84330wmy.127.1610363159783;
        Mon, 11 Jan 2021 03:05:59 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s133sm21303578wmf.38.2021.01.11.03.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 03:05:59 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:05:57 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH v3] Drivers: hv: vmbus: Add /sys/bus/vmbus/hibernation
Message-ID: <20210111110557.bvh6iym7575lgrko@liuwe-devbox-debian-v2>
References: <20210107014552.14234-1-decui@microsoft.com>
 <MWHPR21MB1593953AC2C121CC6888D9A5D7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593953AC2C121CC6888D9A5D7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Jan 07, 2021 at 06:08:51PM +0000, Michael Kelley wrote:
> From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, January 6, 2021 5:46 PM
> > 
> > When a Linux VM runs on Hyper-V, if the host toolstack doesn't support
> > hibernation for the VM (this happens on old Hyper-V hosts like Windows
> > Server 2016, or new Hyper-V hosts if the admin or user doesn't declare
> > the hibernation intent for the VM), the VM is discouraged from trying
> > hibernation (because the host doesn't guarantee that the VM's virtual
> > hardware configuration will remain exactly the same across hibernation),
> > i.e. the VM should not try to set up the swap partition/file for
> > hibernation, etc.
> > 
> > x86 Hyper-V uses the presence of the virtual ACPI S4 state as the
> > indication of the host toolstack support for a VM. Currently there is
> > no easy and reliable way for the userspace to detect the presence of
> > the state (see https://lkml.org/lkml/2020/12/11/1097).  Add
> > /sys/bus/vmbus/hibernation for this purpose.
> > 
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
[...]
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Queued for hyperv-next. Thanks.

Wei.

> 
