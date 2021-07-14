Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608563C89C0
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 19:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhGNR3q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 13:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhGNR3q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 13:29:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D38EA613BE;
        Wed, 14 Jul 2021 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626283613;
        bh=sOy4cSiHFkDFSpegtUnQPJIOAJT/XgUnqunfTIjGQz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=av703ACT68Kjwrq55XbCZTUvYgLH5HXUhcQJ62rd1y+Pf7PukrCeVl4J4Jz2OIuGU
         x2WFzojLx6ocvJsUXB39jZCNacFBKPxVUIO+Y1dv8/f8+ezkaXTy/p/s+LKA9MUIbD
         DikTNWZvc+CHIP3Rpdhv77YMcKuOIL0ninNIOGrM=
Date:   Wed, 14 Jul 2021 19:26:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     longli@linuxonhyperv.com
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
Subject: Re: [Patch v3 2/3] Drivers: hv: add Azure Blob driver
Message-ID: <YO8eWsvgA5j3PLhd@kroah.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
 <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626230722-1971-3-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 13, 2021 at 07:45:21PM -0700, longli@linuxonhyperv.com wrote:
> +static struct miscdevice az_blob_misc_device = {
> +	MISC_DYNAMIC_MINOR,
> +	"azure_blob",
> +	&az_blob_client_fops,
> +};

Named initializers please.
