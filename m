Return-Path: <linux-hyperv+bounces-1488-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D7843852
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985B628AA2C
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245BA55C32;
	Wed, 31 Jan 2024 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gfXKsrrg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC755B1FD;
	Wed, 31 Jan 2024 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687650; cv=none; b=fF33IFaYH1o3z/a0zwfCQOC+PPv2T7wJ+xjVZ9NENSbrzqguNc3yuB6SxSowkFjb14TI05Z18nRRnDNxakjOeDQ0kAKyYpi82n48qOfGjqyivEKV+kMzLMhFjcHUSu/gnrcF/Rg4a23AiCPcvMj/dCTpgH8eM/IqGZV7CpuAnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687650; c=relaxed/simple;
	bh=m6C4Ku8bvmkbexxJOJ7sBnHQ+qywQOk01yROQJjxJrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8JV+BPbaSYUQIrWBaX/Brb3JtJryOqRCqjXUxAa85AztGifCH59xzLDjyM/RrYDciNH+A80QATgpX+pvnd0nlt6+wInS2FDM6hCOH9GABAt3cwKa0vwVNrZ7I6mVVX3/5x+Ru5tu4rlcxU1x5s+//Pemjtjb6qPyvvo3W069rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gfXKsrrg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id BE57E20B2000; Tue, 30 Jan 2024 23:54:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE57E20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706687644;
	bh=7DgOp55USUCAv7zrw7ngdlEyvKDTOomQA+HSmXHyj7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfXKsrrgRkpo0YCzOcCl1PnELBK0m/Vgxdtv6pLH9mgn4Hy8r8xsiAUioe3Qb1U5S
	 sDseMiQeaGw9F7S/iwBcz8NxDyjRm5Ih/iS65S8qI4xZsgiVxJBP94Vsq8ACZUmJbh
	 CaP57jfT5YDpHZ8PT/0ls0aYwoL/rnArELGVh4+Y=
Date: Tue, 30 Jan 2024 23:54:04 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Message-ID: <20240131075404.GA18190@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SA1PR21MB1335C5554F769454AAEDE1C8BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1335C5554F769454AAEDE1C8BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Jan 30, 2024 at 08:13:21PM +0000, Dexuan Cui wrote:
> > From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Sent: Monday, January 29, 2024 11:19 PM
> >  [...]
> > If hv_netvsc driver is removed and reloaded, the NET_DEVICE_REGISTER
> 
> s/removed/unloaded/
> unloaded looks more accurate to me :-)
> 
> > [...]
> > Tested-on: Ubuntu22
> > Testcases: LISA testsuites
> > 	   verify_reload_hyperv_modules, perf_tcp_ntttcp_sriov
> IMO the 3 lines can be removed: this bug is not specific to Ubuntu, and the
> test case names don't provide extra value to help understand the issue
> here and they might cause more questions unnecessarily, e.g. what's LISA,
> what exactly do the test cases do.
> 
> > +/* Macros to define the context of vf registration */
> > +#define VF_REG_IN_PROBE		1
> > +#define VF_REG_IN_RECV_CBACK	2
> 
> I think VF_REG_IN_NOTIFIER is a better name?
> RECV_CBALL looks inaccurate to me.
> 
> > @@ -2205,8 +2209,11 @@ static int netvsc_vf_join(struct net_device
> > *vf_netdev,
> >  			   ndev->name, ret);
> >  		goto upper_link_failed;
> >  	}
> > -
> > -	schedule_delayed_work(&ndev_ctx->vf_takeover,
> > VF_TAKEOVER_INT);
> > +	/* If this registration is called from probe context vf_takeover
> > +	 * is taken care of later in probe itself.
> I suspect "later in probe itself" is not accurate.
> If 'context' is VF_REG_IN_PROBE, I suppose what happens here is:
> after netvsc_probe() finishes, the netvsc interface becomes available,
> so the user space will ifup it, and netvsc_open() will UP the VF interface,
> and netvsc_netdev_event() is called for the VF with event ==
> NETDEV_POST_INIT (?) and NETDEV_CHANGE, and the data path is
> switched to the VF.
> 
> If my understanding is correct, I think in the case of 'context' ==
> VF_REG_IN_PROBE, I suspect the "Align MTU of VF with master"
> and the "sync address list from ndev to VF" in __netvsc_vf_setup() are
> omitted? If so, should this be fixed? e.g. Not sure if the below is an issue or not:
> 1) a VF is bound to a NetVSC interface, and a user sets the MTUs to 1024.
> 2) rmmod hv_netvsc
> 3) modprobe hv_netvsc
> 4) the netvsc interface uses MTU=1500 (the default), and the VF still uses 1024.
> 
> > @@ -2597,6 +2604,34 @@ static int netvsc_probe(struct hv_device *dev,
> >  	}
> > 
> >  	list_add(&net_device_ctx->list, &netvsc_dev_list);
> > +
> > +	/* When the hv_netvsc driver is removed and readded, the
> 
> s/removed and readded/unloaded and reloaded/
> 
> > +	 * NET_DEVICE_REGISTER for the vf device is replayed before
> > probe
> > +	 * is complete. This is because register_netdevice_notifier() gets
> > +	 * registered before vmbus_driver_register() so that callback func
> > +	 * is set before probe and we don't miss events like
> > NETDEV_POST_INIT
> > +	 * So, in this section we try to register each matching
> 
> Looks like there are spaces at the end of the line. We can move up a few words
> from the next line :-)
> 
> s/each matching/the matching/
> A NetVSC interface has only 1 matching VF device.
> 
> > +	 * vf device that is present as a netdevice, knowing that it's register
> 
> s/it's/its/
> 
> > +	 * call is not processed in the netvsc_netdev_notifier(as probing is
> > +	 * progress and get_netvsc_byslot fails).
> > +	 */
> > +	for_each_netdev(dev_net(net), vf_netdev) {
> > +		if (vf_netdev->netdev_ops == &device_ops)
> > +			continue;
> > +
> > +		if (vf_netdev->type != ARPHRD_ETHER)
> > +			continue;
> > +
> > +		if (is_vlan_dev(vf_netdev))
> > +			continue;
> > +
> > +		if (netif_is_bond_master(vf_netdev))
> > +			continue;
> 
> The code above is duplicated from netvsc_netdev_event().
> Can we add a new helper function is_matching_vf() to avoid the duplication?
Sure, I will do that. Thanks
> 
> > +		netvsc_prepare_bonding(vf_netdev);
> > +		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
> > +		__netvsc_vf_setup(net, vf_netdev);
> 
> add a "break;' ?
With MANA devices and multiport support there, the individual ports are also net_devices.
Wouldn't this be needed for such scenario(where we have multiple mana port net devices) to
register them all?
> 
> > +	}
> >  	rtnl_unlock();

