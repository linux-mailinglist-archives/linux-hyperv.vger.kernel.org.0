Return-Path: <linux-hyperv+bounces-2874-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0E9960095
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 06:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C767B283589
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 04:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E547F69;
	Tue, 27 Aug 2024 04:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PLrae34h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC0513A24A;
	Tue, 27 Aug 2024 04:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734528; cv=none; b=A+J3bN1faXDE+9/qiMO5846uo/8CftYf8pgTuKl69XcgVxMWR/O7kNyz4SvbkLmNEl11JsZ0AkrHHZgNmXlqFhr538YaL80GNj1/Ktp7edVwQObapCtbx7FpdbCgGuaejaBA23+L7FEFtl0qdTpIrmL0K4U9CNCZEz26EpN+1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734528; c=relaxed/simple;
	bh=q0nFpfwDB71M8hRiJH0fFpqrz1a/viVuLN0yaqfzmOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reyOXcrEjE8vKmCs0M6yLrpPddlIKD2dpIpwz7izZEwfHXbzyRkPd2qpXEvY/ocE5mV6F7OGG29B3yHxD+3Pxpe8rI2pOGtMZY66Frb0lwFmf/buWiPHnQ91HqsRzb39XVGOWozvFzkZNGtAGLsqzJJYRs6mwBY5vAT0IwhP/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PLrae34h; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C027520B7165; Mon, 26 Aug 2024 21:55:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C027520B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724734521;
	bh=y7u/adLfEfWQBZYvxPMqom7lgVuRUle0taA6pKvQB+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLrae34hkaXgZs8gWphQNxMWNt0Jm6TjvjKYFazPZRlMrAdUWJB+95Mxa9pJuE8BD
	 UXUlqSA6lCuK6oBH8e1ocHtKS6MNNTuWXjQ175mlt6aa/fd9jCj1/QEIl7tSgvjpdY
	 XdU85MKV6Z1RyTKNALnxmmj4SbpIlm8SeosBCLmA=
Date: Mon, 26 Aug 2024 21:55:21 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ernis@microsoft.com" <ernis@microsoft.com>
Subject: Re: [PATCH v3] net: netvsc: Update default VMBus channels
Message-ID: <20240827045521.GA17487@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1724339168-20913-1-git-send-email-ernis@linux.microsoft.com>
 <SN6PR02MB415769AD9CC9B1C9398DCC6CD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB415769AD9CC9B1C9398DCC6CD4882@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Aug 23, 2024 at 04:37:17PM +0000, Michael Kelley wrote:
> From: Erni Sri Satya Vennela <ernis@linux.microsoft.com> Sent: Thursday, August 22, 2024 8:06 AM
> > 
> > Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> > Linux netvsc from 8 to 16 to align with Azure Windows VM
> > and improve networking throughput.
> > 
> > For VMs having less than 16 vCPUS, the channels depend
> > on number of vCPUs. Between 16 to 64 vCPUs, the channels
> > default to VRSS_CHANNEL_DEFAULT. For greater than 64 vCPUs,
> > set the channels to number of physical cores / 2 returned by
> > netif_get_num_default_rss_queues() as a way to optimize CPU
> > resource utilization and scale for high-end processors with
> > many cores. Due to hyper-threading, the number of
> > physical cores = vCPUs/2.
> 
> But note that a given physical processor may or may not support
> hyper-threading. For example, the physical processor used for
> ARM64 VMs in Azure does not have hyper-threading. And even
> if the physical processor supports hyper-threading, the VM might
> not see hyper-threading as enabled. Many Azure GPU-based VM
> sizes see only full cores, with no hyper-threading. It's also possible
> to boot Linux with hyper-threading disabled even if the VM sees
> hyper-threaded cores (the "nosmt" or "smt=1" kernel boot option).
> 
> Your code below probably isn't affected when hyper-threading
> isn't present. But in the interest of accuracy, the discussion here
> in the commit message should qualify the use of "vCPU/4" as
> the number of channels. It might be "vCPU/2" when
> hyper-threading isn't present or is disabled, and for vCPU
> counts between 16 and 64, you'll get more than 16 channels.
> 
> > Maximum number of channels are by default set to 64.
> > 
> > Based on this change the channel creation would change as follows:
> > 
> > -------------------------------------------------------------
> > | No. of vCPU	|  dev_info->num_chn	| channels created  |
> > -------------------------------------------------------------
> > |  0-16		|       16		|       vCPU        |
> 
> Nit: Presumably we won't ever have 0 vCPUs.  :-)
> 
> > | >16 & <=64	|       16		|       16          |
> > | >64 & <=256	|       vCPU/4		|       vCPU/4      |
> > | >256		|       vCPU/4		|       64          |
> > -------------------------------------------------------------
> > 
> > Performance tests showed significant improvement in throughput:
> > - 0.54% for 16 vCPUs
> > - 0.83% for 32 vCPUs
> > - 0.86% for 48 vCPUs
> > - 9.72% for 64 vCPUs
> > - 13.57% for 96 vCPUs
> > 
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> > Changes in v3:
> > * Use netif_get_num_default_rss_queues() to set channels
> > * Change terminology for channels in commit message
> > ---
> > Changes in v2:
> > * Set dev_info->num_chn based on vCPU count.
> > ---
> >  drivers/net/hyperv/hyperv_net.h | 2 +-
> >  drivers/net/hyperv/netvsc_drv.c | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> > index 810977952f95..e690b95b1bbb 100644
> > --- a/drivers/net/hyperv/hyperv_net.h
> > +++ b/drivers/net/hyperv/hyperv_net.h
> > @@ -882,7 +882,7 @@ struct nvsp_message {
> > 
> >  #define VRSS_SEND_TAB_SIZE 16  /* must be power of 2 */
> >  #define VRSS_CHANNEL_MAX 64
> > -#define VRSS_CHANNEL_DEFAULT 8
> > +#define VRSS_CHANNEL_DEFAULT 16
> > 
> >  #define RNDIS_MAX_PKT_DEFAULT 8
> >  #define RNDIS_PKT_ALIGN_DEFAULT 8
> > diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> > index 44142245343d..a6482afe4217 100644
> > --- a/drivers/net/hyperv/netvsc_drv.c
> > +++ b/drivers/net/hyperv/netvsc_drv.c
> > @@ -987,7 +987,8 @@ struct netvsc_device_info *netvsc_devinfo_get(struct netvsc_device *nvdev)
> >  			dev_info->bprog = prog;
> >  		}
> >  	} else {
> > -		dev_info->num_chn = VRSS_CHANNEL_DEFAULT;
> > +		dev_info->num_chn = max(VRSS_CHANNEL_DEFAULT,
> > +					netif_get_num_default_rss_queues());
> >  		dev_info->send_sections = NETVSC_DEFAULT_TX;
> >  		dev_info->send_section_size = NETVSC_SEND_SECTION_SIZE;
> >  		dev_info->recv_sections = NETVSC_DEFAULT_RX;
> > --
> > 2.34.1
> > 
Thank you for the knowledge you shared. I’ll update the patch
with your suggestions in the next version.

