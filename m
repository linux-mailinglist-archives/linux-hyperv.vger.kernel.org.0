Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B658B1F08E4
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 Jun 2020 23:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgFFVtV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 6 Jun 2020 17:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgFFVtV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 6 Jun 2020 17:49:21 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C31C03E96A;
        Sat,  6 Jun 2020 14:49:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k8so10295855edq.4;
        Sat, 06 Jun 2020 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VgP2+hVV/vkDoaX74ozw6bS7RaSefK4qnU1nlNlh2KY=;
        b=rUmvK9G5CX58iNlQ+Vi8P0V249bdMA0niHCgNrgpcDEyj3/ryVX0Ut2DTZ2kjWkknL
         ni0g2LndyqCguuuDE96Rame5trxY6EchsqV1UU4e88y2c1b4tBFo1oSlE6mQx9j+5ul+
         wSFcOgtT2PuhoCVNJJtaqXtJH73/+QXfKNrycMUzzbEIMnyb1tvqbsC9v5sJsShq8Y2F
         OadkSpP+wtlUi9azH1G2QRUjrvNiHLqrqRA0FWVd0ZO3bS4LkwgAMLNzxaKurenXCsRt
         Ny5LTesJg3HeeOUTa5/pnbdu5BOjjY/qfBnSZBlQw13FfViXbKKuauHHpZ1h4hnGwOCU
         ElPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VgP2+hVV/vkDoaX74ozw6bS7RaSefK4qnU1nlNlh2KY=;
        b=WeIAvSBelZjeja9iiO7XTZetou7Hu4NI3fbCg2JHuYUPO2LAGWbbzGKsTrCWp3xPbG
         6fV8JSY/K+kJr5AeJW0dPgfFXpt+AY28jYcixwSYZsVYk6+dQA062+0mw9i5B+bpbSSo
         VbhpFwfO+Yels3zCGe+29DoQng1ZSRxoe99VIn6sF6SuywMFpNr1MYtV4Vl0s+2EBHdc
         H+Nvnw5qhjsbL+v8nJDauzbofTGVcxpWTPGq6U6hYk+GsF3ixvchKDAQxeGx4Uh+vcAs
         WaQL09LB8bJSCLCZisAqvd7MfJwl+HeoJy9iuUlFb9pcgcPP0FqnTlmjOrwVCtZnIVyH
         DN0g==
X-Gm-Message-State: AOAM530Ews8FtTON8qcxXRoaTiyhLkSfbVAn8AwZ6JLt8czXzfW4zWbP
        LuZ29GSwxeK6LT65IDbwcb4=
X-Google-Smtp-Source: ABdhPJxTi/f30QiIvxQcfBUT8nM9eLRx70mY91L3DfrqCAtS8xFMG8gGJPi+HlIoNjN+B9TcdrSz+w==
X-Received: by 2002:a50:ee08:: with SMTP id g8mr14657896eds.267.1591480159057;
        Sat, 06 Jun 2020 14:49:19 -0700 (PDT)
Received: from andrea (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id 63sm7896084edm.48.2020.06.06.14.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 14:49:17 -0700 (PDT)
Date:   Sat, 6 Jun 2020 23:49:09 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <Nuno.Das@microsoft.com>
Subject: Re: [RFC PATCH 1/2] Drivers: hv: vmbus: Re-balance channel
 interrupts across CPUs at CPU hotplug
Message-ID: <20200606214909.GA28369@andrea>
References: <20200526223218.184057-1-parri.andrea@gmail.com>
 <20200526223218.184057-2-parri.andrea@gmail.com>
 <SN6PR2101MB10562BB7B20846C8C711F2DDD78B0@SN6PR2101MB1056.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR2101MB10562BB7B20846C8C711F2DDD78B0@SN6PR2101MB1056.namprd21.prod.outlook.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -515,6 +519,8 @@ static void vmbus_add_channel_work(struct work_struct *work)
> >  	if (ret != 0) {
> >  		pr_err("unable to add child device object (relid %d)\n",
> >  			newchannel->offermsg.child_relid);
> > +		if (hv_is_perf_channel(newchannel))
> > +			free_chn_counts(&newchannel->device_obj->chn_cnt);
> 
> You could drop the "if" condition and just always call free_chn_counts() since
> it will do the right thing for non-perf channels where the memory was never
> allocated.

Well, AFAICT, the above would do the "right" thing for non-perf channels
without calling kfree() twice.  ;-)  It would also serve as a hard-coded
"reminder" of the fact that there is no alloc_chn_counts() for them.  No
strong opinions though, will drop for the next submission...


> > +static void filter_vp_index(struct hv_device *hv_dev, cpumask_var_t cpu_msk)
> > +{
> > +	/*
> > +	 * The selection of the target CPUs is performed in two domains,
> > +	 * the device domain and the connection domain.  At each domain,
> > +	 * in turn, invalid CPUs are filtered out at two levels, the CPU
> 
> I would drop the word "invalid".  You are filtering out CPUs that meet the
> criteria in the sentence starting after the colon below.

Agreed, will drop.


> > +static void balance_vp_index(struct vmbus_channel *chn,
> > +			     struct hv_device *hv_dev, cpumask_var_t cpu_msk)
> > +{
> > +	u32 cur_cpu = chn->target_cpu, tgt_cpu = cur_cpu;
> > +
> > +	if (chn->state != CHANNEL_OPENED_STATE) {
> > +		/*
> > +		 * The channel may never have been opened or it may be in
> > +		 * a closed/closing state; if so, do not touch the target
> > +		 * CPU of this channel.
> > +		 */
> > +		goto update_chn_cnts;
> > +	}
> > +
> > +	/*
> > +	 * The channel was open, and it will remain open until we release
> > +	 * channel_mutex, cf. the use of channel_mutex and channel->state
> > +	 * in vmbus_disconnect_ring() -> vmbus_close_internal().
> > +	 */
> > +
> > +	if (!hv_is_perf_channel(chn)) {
> > +		/*
> > +		 * Only used by the CPU hot removal path, remark that
> > +		 * the connect CPU can not go offline.
> 
> To be super explicit in the comment:  If the channel is not a
> performance channel, then it does not participate in the balancing,
> and we move it back to interrupting the VMBUS_CONNECT_CPU for
> lack of a better choice.  Because non-perf channels are initially set to 
> interrupt the VMBUS_CONNECT_CPU, the only way a non-perf channel
> could be found in this state (i.e., set to a CPU other than
> VMBUS_CONNECT_CPU) is a manual change through the sysfs interface.

The comment was indeed rather meant to make explicit a "please go read
the caller, carefully..." where, among other things, at least parts of
the remarks you pointed out above are spelled out.  But I won't be the
one stingy with comments!  ;-)  Will apply, thanks for the suggestion.


> > +void vmbus_balance_vp_indexes_at_cpuhp(unsigned int cpu, bool add)
> > +{
> > +	struct vmbus_channel *chn, *sc;
> > +	cpumask_var_t cpu_msk;
> > +
> > +	lockdep_assert_cpus_held();
> > +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> > +
> > +	WARN_ON(!cpumask_test_cpu(cpu, cpu_online_mask));
> > +
> > +	/* See the header comment for vmbus_send_modifychannel(). */
> > +	if (vmbus_proto_version < VERSION_WIN10_V4_1)
> > +		return;
> > +
> > +	if (!alloc_cpumask_var(&cpu_msk, GFP_KERNEL))
> > +		return;
> > +
> > +	reset_chn_counts(&vmbus_connection.chn_cnt);
> > +
> > +	list_for_each_entry(chn, &vmbus_connection.chn_list, listentry) {
> > +		struct hv_device *dev = chn->device_obj;
> > +
> > +		/*
> > +		 * The device may not have been allocated/assigned to
> > +		 * the primary channel yet; if so, do not balance the
> > +		 * channels associated to this device.  If dev != NULL,
> > +		 * the synchronization on channel_mutex ensures that
> > +		 * the device's chn_cnt has been (properly) allocated
> > +		 * *and* initialized, cf. vmbus_add_channel_work().
> > +		 */
> > +		if (dev == NULL)
> > +			continue;
> > +
> > +		/*
> > +		 * By design, non-"perf" channels do not take part in
> > +		 * the balancing process.
> > +		 *
> > +		 * The user may have assigned some non-"perf" channel
> > +		 * to this CPU.  To satisfy the user's request to hot
> > +		 * remove the CPU, we will re-assign such channels to
> > +		 * the connect CPU; cf. balance_vp_index().
> > +		 */
> > +		if (!hv_is_perf_channel(chn)) {
> > +			if (add)
> > +				continue;
> > +			/*
> > +			 * Assume that the non-"perf" channel has no
> > +			 * sub-channels.
> > +			 */
> 
> The "if" statement below could use a bit further explanation to help
> the reader. :-)  If this non-perf channel is assigned to some CPU other
> than the one we are hot-removing, then we execute the "continue"
> statement and leave its target CPU unchanged.  But if it is assigned
> to the CPU we are hot removing, then we need to move the channel
> to some other CPU.
> 
> I'm also not clear on how the above comment about having no
> sub-channels is relevant.  Maybe a bit more explanation would
> help.

That comment was meant to simply stress the fact that we can "continue"
without looping over/checking the sub-channels, because we know that the
channel in question has no sub-channels.  ;-)  (BTW, for the very same
reason, we have no "if (!hv_is_perf_channel(sc))..." in the loop below.)

So, maybe something like:

	/*
	 * If this non-"perf" channel is assigned to some...
	 * [your text/explanation above].
	 */
	if (chn->target_cpu != cpu) {
		/*
		 * Non-"perf" channels have no sub-channels:
		 * no need to loop over sc_list.
		 */
		continue;
	}

??
	 

> > +			if (chn->target_cpu != cpu)
> > +				continue;
> > +		} else {
> > +			reset_chn_counts(&dev->chn_cnt);
> > +		}
> > +
> > +		cpumask_copy(cpu_msk, cpu_online_mask);
> > +		if (!add)
> > +			cpumask_clear_cpu(cpu, cpu_msk);
> > +		balance_vp_index(chn, dev, cpu_msk);
> > +
> > +		list_for_each_entry(sc, &chn->sc_list, sc_list) {
> > +			cpumask_copy(cpu_msk, cpu_online_mask);
> > +			if (!add)
> > +				cpumask_clear_cpu(cpu, cpu_msk);
> > +			balance_vp_index(sc, dev, cpu_msk);
> > +		}
> > +	}
> > +
> > +	free_cpumask_var(cpu_msk);
> > +}


> >  int hv_synic_init(unsigned int cpu)
> >  {
> > +	/*
> > +	 * The CPU has been hot added: try to re-balance the channels
> > +	 * across the online CPUs (including "this" CPU), provided that
> > +	 * the VMBus is connected; in part., avoid the re-balancing at
> > +	 * the very first CPU initialization.
> > +	 *
> > +	 * See also inline comments in hv_synic_cleanup().
> > +	 */
> > +	if (vmbus_connection.conn_state == CONNECTED) {
> > +		mutex_lock(&vmbus_connection.channel_mutex);
> > +		vmbus_balance_vp_indexes_at_cpuhp(cpu, true);
> 
> Does the target CPU have its bit in cpu_online_mask set at the time this
> is executed?  reset_chn_counts() does a for_each_online_cpu() loop, and
> we want to make sure the count for this CPU gets reset to zero.

Yes, it does:  We're here (in CPUHP_AP_ONLINE_DYN) near the end of the
"CPU-online" process; IIUC, the bit in question is set earlier in this
process/before the CPU reaches CPUHP_AP_ONLINE_IDLE.

So, yeah, I think I would agree in saying that that:

  WARN_ON(!cpumask_test_cpu(cpu, cpu_online_mask));

(in vmbus_balance_vp_indexes_at_cpuhp()) is more about "paranoid" (for
future changes/uses) than anything else.  I'm keeping that for now.


> > @@ -980,6 +980,9 @@ static void vmbus_device_release(struct device *device)
> >  	mutex_lock(&vmbus_connection.channel_mutex);
> >  	hv_process_channel_removal(channel);
> >  	mutex_unlock(&vmbus_connection.channel_mutex);
> > +
> > +	if (hv_is_perf_channel(channel))
> > +		free_chn_counts(&hv_dev->chn_cnt);
> 
> Again, can drop the 'if' statement.

As mentioned above, either way works for me.  Will drop it for the next
version.

Thanks,
  Andrea
