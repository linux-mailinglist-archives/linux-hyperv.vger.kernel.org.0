Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9819A37F20
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 22:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfFFU4M (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 16:56:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46779 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfFFU4M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 16:56:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so981686pfy.13
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Jun 2019 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f+qh2d3h2Cak8z3Q5w4GVP90hwUOyBhHnrt7sxIpWcE=;
        b=kHs16fY+9/UjHoiPLwdwJf70lFFtqD8sajVuC90FEyUp6E66EXMQsmQlDsZ/gda4Mf
         EP551pT52JgkqNNljRkhPafG78Nl3GaZQUL23iS73GCEQdQ9b7gYmY0EZzdocyEm8SuA
         q66tDhdRyob6TQ5+h5lS3wsnTc/V4kWLrQxiv9pB9P+cffK26SpJPHb1PvJYHwsVyk8a
         J6tbG6eTIonDaGJFIF10cXifdcDTOobDoDhpXVQZ/4aTRV2FRvKnZp47Jd0jZ6VnTQ8P
         Ud7u+WPFpkrvpRpMeIK0fAF9qqRVKn6rQnMejgX49b3BuC6sX1SmpnfigZUpDsbVIn5t
         yTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+qh2d3h2Cak8z3Q5w4GVP90hwUOyBhHnrt7sxIpWcE=;
        b=FRTm1GpIDh0HMFHqJR1d+LAGPF+mTOvECSPncRFBwf1NJyL5zfwN9fOhAqOSngel8y
         L122dcsQYvy53cUMDot07LoZYxqtOxrhRliNwy19OU9UKfhIHDQUAKR4PDuRhds6Pf+X
         MlontadeQLNl3J0HwmcnQVfaihOeI6hkYfEJZmKJcE74AFIeVp+T2pk1mAMPgJPLBrp0
         TEpqwWeRWpkIqohQnO5RuDdkAkQ+7xQ5Cw/8j1Jq6W5Lc6H12faY6EWEg4tQN+a6+0JW
         bYFITxmBk+AozWMjtyAGG/fU7+qGD6g7Y7ykAQOBaQ2Z2CrEkzcH/KdkXonBoT+bwPdM
         Vmeg==
X-Gm-Message-State: APjAAAWJqlKUQO1SJcGJyNDIwsUYU92cpT7wqZI/ZPhlGA/cZtOOC5CC
        02LHWfLL2ShTPXF6UW1/FTnwWA==
X-Google-Smtp-Source: APXvYqxMFepDc+wuB9EN5hXWkmFSydsMgQOiZUx6N4+fSe4gLbUTBlVhOP1hlzr+2rA583fTgbdovQ==
X-Received: by 2002:a63:1919:: with SMTP id z25mr435335pgl.440.1559854571712;
        Thu, 06 Jun 2019 13:56:11 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id b15sm60621pff.31.2019.06.06.13.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 13:56:11 -0700 (PDT)
Date:   Thu, 6 Jun 2019 13:56:09 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     netdev@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus network devices.
Message-ID: <20190606135609.5119a298@hermes.lan>
In-Reply-To: <20190605185114.12456-1-sthemmin@microsoft.com>
References: <20190605185114.12456-1-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed,  5 Jun 2019 11:51:14 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Doing asynchronous probing can lead to reordered network device names.
> And because udev doesn't have any useful information to construct a
> persistent name, this causes VM's to sporadically boot with reordered
> device names and no connectivity.
> 
> This shows up on the Ubuntu image on larger VM's where 30% of the
> time eth0 and eth1 get swapped.
> 
> Note: udev MAC address policy is disabled on Azure images
> because the netvsc and PCI VF will have the same mac address.
> 
> Fixes: af0a5646cb8d ("use the new async probing feature for the hyperv drivers")
> Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 06393b215102..1a2c32111106 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2411,9 +2411,6 @@ static struct  hv_driver netvsc_drv = {
>  	.id_table = id_table,
>  	.probe = netvsc_probe,
>  	.remove = netvsc_remove,
> -	.driver = {
> -		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> -	},
>  };
>  
>  /*

Even though storage can handle out of order devices, networking can not.
The network devices in Hyper-V do not have any persistant properties that will
work with existing udev. The current kernel is breaking current distributions.
This patch fixes it, why did you reject it?
