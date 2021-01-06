Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A092EBD06
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 12:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbhAFLJk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 06:09:40 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:39940 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbhAFLJk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 06:09:40 -0500
Received: by mail-wm1-f43.google.com with SMTP id r4so2261422wmh.5;
        Wed, 06 Jan 2021 03:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zj0igQMTTRlNLhn2KPaioiFIoqyaeGRUUPgqEDNtlgk=;
        b=E4xWUV7PjrfOQkocsrIGOg+4KDM4QIsc8UvMa+KiSM+fxWU58xmxLaSRcRIFSjuFO1
         I/22xki1ttbqy7mUIHOAjjYtSaSftdtLNru3UrrhflQ5s2RmReo7kVttEnGfKIc4Bkum
         UrHkC0/xETXf472X2g0z1BEd1ytEfdhdZzH0Vx41T4dzj39bvK8zBe/FN4tm1uD3Whx7
         Znzir+hsmrf8lJXz/4ldpgf2IaL0YsLCSmRmY8biuI+oxRvQ1eGYSyiMwjgvWdLBUDhH
         Ju2nUF3D+/EWx6gqbmmDhx5BXxDPKyrbM14hYlGPNeTMCiWkgjE+iAsn8IAtCePucj3h
         MG1g==
X-Gm-Message-State: AOAM533OGfk8dhycwfwX4JtWq+hULD6BLaNrFpMb8RcmXLGU6iZb3R+4
        DBDml/e/I873DXieIm/xRrU=
X-Google-Smtp-Source: ABdhPJyb5jWLwAmy6e8/9MtS/gwbr+foCTC9yXXutVnqwUuA1+QsP+kQW4F6P2PUWR4I7zV7cl7mZw==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr3137421wmd.39.1609931337769;
        Wed, 06 Jan 2021 03:08:57 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g78sm2527918wme.33.2021.01.06.03.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 03:08:57 -0800 (PST)
Date:   Wed, 6 Jan 2021 11:08:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Add
 /sys/bus/vmbus/supported_features
Message-ID: <20210106110856.i23e7alpf2biirsu@liuwe-devbox-debian-v2>
References: <20210106000434.5551-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106000434.5551-1-decui@microsoft.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 05, 2021 at 04:04:34PM -0800, Dexuan Cui wrote:
> When a Linux VM runs on Hyper-V, if the host toolstack doesn't support
> hibernation for the VM (this happens on old Hyper-V hosts like Windows
> Server 2016, or new Hyper-V hosts if the admin or user doesn't declare
> the hibernation intent for the VM), the VM is discouraged from trying
> hibernation (because the host doesn't guarantee that the VM's virtual
> hardware configuration will remain exactly the same across hibernation),
> i.e. the VM should not try to set up the swap partition/file for
> hibernation, etc.
> 
> x86 Hyper-V uses the presence of the virtual ACPI S4 state as the
> indication of the host toolstack support for a VM. Currently there is
> no easy and reliable way for the userspace to detect the presence of
> the state (see https://lkml.org/lkml/2020/12/11/1097).  Add
> /sys/bus/vmbus/supported_features for this purpose.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

LGTM. I will wait a bit for others to comment.

> ---
> 
> Change in v2:
> 	Added a "Values:" section
> 	Updated "Date:"
> 
>  Documentation/ABI/stable/sysfs-bus-vmbus |  9 +++++++++
>  drivers/hv/vmbus_drv.c                   | 20 ++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
> index c27b7b89477c..c8d56389b7be 100644
> --- a/Documentation/ABI/stable/sysfs-bus-vmbus
> +++ b/Documentation/ABI/stable/sysfs-bus-vmbus
> @@ -1,3 +1,12 @@
> +What:		/sys/bus/vmbus/supported_features
> +Date:		Jan 2021
> +KernelVersion:	5.11
> +Contact:	Dexuan Cui <decui@microsoft.com>
> +Description:	Features specific to VMs running on Hyper-V
> +Values:		A list of strings.
> +		hibernation: the host toolstack supports hibernation for the VM.
> +Users:		Daemon that sets up swap partition/file for hibernation
> +
>  What:		/sys/bus/vmbus/devices/<UUID>/id
>  Date:		Jul 2009
>  KernelVersion:	2.6.31
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index d491fdcee61f..958487a40a18 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -678,6 +678,25 @@ static const struct attribute_group vmbus_dev_group = {
>  };
>  __ATTRIBUTE_GROUPS(vmbus_dev);
>  
> +/* Set up bus attribute(s) for /sys/bus/vmbus/supported_features */
> +static ssize_t supported_features_show(struct bus_type *bus, char *buf)
> +{
> +	bool hb = hv_is_hibernation_supported();
> +
> +	return sprintf(buf, "%s\n", hb ? "hibernation" : "");
> +}
> +
> +static BUS_ATTR_RO(supported_features);
> +
> +static struct attribute *vmbus_bus_attrs[] = {
> +	&bus_attr_supported_features.attr,
> +	NULL,
> +};
> +static const struct attribute_group vmbus_bus_group = {
> +	.attrs = vmbus_bus_attrs,
> +};
> +__ATTRIBUTE_GROUPS(vmbus_bus);
> +
>  /*
>   * vmbus_uevent - add uevent for our device
>   *
> @@ -1024,6 +1043,7 @@ static struct bus_type  hv_bus = {
>  	.uevent =		vmbus_uevent,
>  	.dev_groups =		vmbus_dev_groups,
>  	.drv_groups =		vmbus_drv_groups,
> +	.bus_groups =		vmbus_bus_groups,
>  	.pm =			&vmbus_pm,
>  };
>  
> -- 
> 2.19.1
> 
