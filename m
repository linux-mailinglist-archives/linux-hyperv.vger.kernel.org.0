Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A282C9225
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Dec 2020 00:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgK3XJJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Nov 2020 18:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbgK3XJH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Nov 2020 18:09:07 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7AC0613CF;
        Mon, 30 Nov 2020 15:08:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id v14so151876wml.1;
        Mon, 30 Nov 2020 15:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jWzZCOEszWMHLVCYdwNQz6KjyOCKD0ZHpNbzolSl8Vg=;
        b=HVI2Jnp/L+oPC4R8Itv/zTMpeoIph6PuFO0AhX7feUgd4Q4OM9O0k/RLKHV/Ta6uFM
         GWRFGODbFBiUpe0h5d+hfCKTgwXjAk6Glz8Y27ONcHdh/CN3H9mH5j8Q/+QTV5ZbSKa2
         58MrDpEVHTArI938PM5LzCedMpvYqU1gS0zqX7HaZd3pgI/2EdPIqxP4N5HkF2rLlZkv
         AkmmVu79wuGizXVl7SjB5ov7JQezKETIDXDAIQHvUL6qEHRSYZbbDJDGT/0miuBM6bJO
         AHew2Mh6BzcfF/tnR76aofB4lHBtqxAXsVR9H7RwAPAP8UOVwEqPpLHmQ/JVoupUE4FV
         3HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWzZCOEszWMHLVCYdwNQz6KjyOCKD0ZHpNbzolSl8Vg=;
        b=juFY3dlHO32UCzFZxpHeNSnFC2Z9vORPI2vgy22XHCeapx1L/+BDSGTM1b9XwCO2dZ
         rsQXic6ruBhuVs9SYvXAacxLa2HOcgG+TIYxfY4BI+Lu17wQADnPjcfFNJIadesSxt6y
         kdYUpnXlheUHlGt6SZOjNQQMKPInXbcJKiU7SHdl71hDBJd0e/CGKSidawIFxkPFkIjd
         D692u/orK2DXPqRjyqlA0G+pmg4+NvEHL8MBOLuaSx0OqEYbhtiZhgZbSVTXp01xIi4h
         73LRE60i3GCRB41391MwNTLi5AUIlf24006bnYtu1bfFydPLaB8J4qcG29nIgLhZrtDh
         vEGw==
X-Gm-Message-State: AOAM530ANctogwh9gG84o2ddW2/Ag1Rj6YFNoB8cd9t1u8ED8JGgCe/a
        H6Rj6e6wR9dVEIzwHdSKMcI=
X-Google-Smtp-Source: ABdhPJxc1ZFzBbrXnyRAhE6y2QZ2U4I6Vo/iayd7EocQplnX0XGQdkCBoIztLRmtRDe1yRBIVvq3Mw==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr130353wmd.70.1606777705787;
        Mon, 30 Nov 2020 15:08:25 -0800 (PST)
Received: from andrea (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id j13sm23442291wrp.70.2020.11.30.15.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:08:25 -0800 (PST)
Date:   Tue, 1 Dec 2020 00:08:18 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Introduce the
 CHANNELMSG_MODIFYCHANNEL_RESPONSE message type
Message-ID: <20201130230818.GA2761@andrea>
References: <20201126191210.13115-1-parri.andrea@gmail.com>
 <MW2PR2101MB105279C034494D505E47EC15D7F61@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB105279C034494D505E47EC15D7F61@MW2PR2101MB1052.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Nov 29, 2020 at 06:29:55PM +0000, Michael Kelley wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Thursday, November 26, 2020 11:12 AM
> > 
> > Quoting from commit 7527810573436f ("Drivers: hv: vmbus: Introduce
> > the CHANNELMSG_MODIFYCHANNEL message type"),
> > 
> >   "[...] Hyper-V can *not* currently ACK CHANNELMSG_MODIFYCHANNEL
> >    messages with the promise that (after the ACK is sent) the
> >    channel won't send any more interrupts to the "old" CPU.
> > 
> >    The peculiarity of the CHANNELMSG_MODIFYCHANNEL messages is
> >    problematic if the user want to take a CPU offline, since we
> >    don't want to take a CPU offline (and, potentially, "lose"
> >    channel interrupts on such CPU) if the host is still processing
> >    a CHANNELMSG_MODIFYCHANNEL message associated to that CPU."
> > 
> > Introduce the CHANNELMSG_MODIFYCHANNEL_RESPONSE(24) message type,
> > which embodies the type of the CHANNELMSG_MODIFYCHANNEL ACK.
> 
> I feel like the commit message needs a bit more detail about the new
> functionality that is added, including introducing the new VMbus protocol
> version 5.3, and then waiting for the response message when running
> with that protocol version of later.   Also, when taking a CPU offline, new
> functionality ensures that there are no pending channel interrupts for
> that CPU.

I'll add details along these lines in the next submission.


> 
> Could/should this patch be broken into multiple patches?
> 
> 1)  Introduce and negotiate VMbus protocol version 5.3.   Note that just
> negotiating version 5.3 should be safe because any ACK messages will
> be cleanly ignored by the old code.
> 2)  Check for pending channel interrupts before taking a CPU offline.
> Wouldn't this check be valid even with the existing code where there is no
> ACK message?  The old code is, in effect, assuming that enough time has
> passed such that the modify channel message has been processed.
> 3)  Code to wait for an ACK message, and code to receive and process an
> ACK message.

I think that the patch could be broken into multiple patches.  I'm still
wondering whether we could/should invoke hv_synic_event_pending() without
an ACK message (like the description above seems to suggest), say, from
the introduction of MODIFYCHANNEL messages...  Thoughts?


> > +static int send_modifychannel_with_ack(struct vmbus_channel *channel, u32 target_vp)
> > +{
> > +	struct vmbus_channel_modifychannel *msg;
> > +	struct vmbus_channel_msginfo *info;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	info = kzalloc(sizeof(struct vmbus_channel_msginfo) +
> > +				sizeof(struct vmbus_channel_modifychannel),
> > +		       GFP_KERNEL);
> > +	if (!info)
> > +		return -ENOMEM;
> > +
> > +	init_completion(&info->waitevent);
> > +	info->waiting_channel = channel;
> > +
> > +	msg = (struct vmbus_channel_modifychannel *)info->msg;
> > +	msg->header.msgtype = CHANNELMSG_MODIFYCHANNEL;
> > +	msg->child_relid = channel->offermsg.child_relid;
> > +	msg->target_vp = target_vp;
> > +
> > +	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> > +	list_add_tail(&info->msglistentry, &vmbus_connection.chn_msg_list);
> > +	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> > +
> > +	if (channel->rescind) {
> > +		ret = -ENODEV;
> > +		goto free_info;
> > +	}
> 
> Does the above check really do anything?  Such checks are sprinkled throughout
> the VMbus code, and I've always questioned their efficacy.  The rescind flag can
> be set without holding the channel_mutex, so as soon as the above code tests
> the flag, it seems like it could change.

Same question (and questioning) here actually.  I'm planning to remove
this check in v2.   Similarly for the ->rescind check below.


> 
> > +
> > +	ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_modifychannel), true);
> 
> Use "sizeof(*msg)" instead?

Applied.


> 
> > +	trace_vmbus_send_modifychannel(msg, ret);
> > +	if (ret != 0)
> > +		goto clean_msglist;
> > +
> > +	/*
> > +	 * Release channel_mutex; otherwise, vmbus_onoffer_rescind() could block on
> > +	 * the mutex and be unable to signal the completion.
> > +	 */
> > +	mutex_unlock(&vmbus_connection.channel_mutex);
> > +	wait_for_completion(&info->waitevent);
> > +	mutex_lock(&vmbus_connection.channel_mutex);
> 
> The calling function, target_cpu_store(), obtains the mutex to synchronize against
> channel closure.  Does releasing the mutex here still ensure the needed synchronization?
> If so, some comments explaining why could be helpful.  I didn't try to reason through it
> all, so I'm not sure.

AFAICT, the synchronization against channel closure just want the mutex
critical section to include the MODIFYCHANNEL post.

AFAICT, different target_cpu_store() invocations remain serialized (by
the mutex in kernfs_fop_write()); maybe this is worth noticing?


> 
> > +
> > +	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> > +	list_del(&info->msglistentry);
> > +	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> > +
> > +	if (channel->rescind) {
> > +		ret = -ENODEV;
> > +		goto free_info;
> > +	}
> 
> Again, I'm wondering if the above is actually useful.

See above.


> 
> > +
> > +	if (info->response.modify_response.status) {
> 
> I'm thinking that current Hyper-V never sends a non-zero status.  But it's good
> to check in case of future changes.  The implication is that a non-zero status means
> that the request to change the target CPU was not performed, correct?

This corresponds to my understanding too.  But you're right, I should
have verified with the Hyper-V team...


> 
> > +		kfree(info);
> > +		return -EAGAIN;
> > +	}
> > +
> > +	kfree(info);
> > +	return 0;
> > +
> > +clean_msglist:
> > +	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> > +	list_del(&info->msglistentry);
> > +	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> 
> The error handling seems more complex than needed.  The "clean_msglist" label
> is only called from one place, so the above code could go inline at that place.

Mmh, it seems also wrong...  IAC, I'll review it before the next
submission, taking into account these remarks.


> 
> > +free_info:
> > +	kfree(info);
> > +	return ret;
> 
> More error handling:  The kfree(info) call is done in three different places.  With
> consistent use of the 'ret' local variable, only one place would be needed.

See above.


> 
> > +}
> > +
> >  /*
> >   * Set/change the vCPU (@target_vp) the channel (@child_relid) will interrupt.
> >   *
> >   * CHANNELMSG_MODIFYCHANNEL messages are aynchronous.  Also, Hyper-V does not
> > - * ACK such messages.  IOW we can't know when the host will stop interrupting
> > - * the "old" vCPU and start interrupting the "new" vCPU for the given channel.
> > + * ACK such messages before VERSION_WIN10_V5_3.  Without ACK, we can not know
> > + * when the host will stop interrupting the "old" vCPU and start interrupting
> > + * the "new" vCPU for the given channel.
> 
> In the interest of clarity, make the above comment slightly more explicit:  When VMbus
> version 5.3 or later is negotiated, Hyper-V always sends an ACK in response to
> CHANNELMSG_MODIFYCHANNEL.  For VMbus version 5.2 and earlier, it never sends an ACK.

Applied.


> > +static void vmbus_onmodifychannel_response(struct vmbus_channel_message_header *hdr)
> > +{
> > +	struct vmbus_channel_modifychannel_response *response;
> > +	struct vmbus_channel_msginfo *msginfo;
> > +	unsigned long flags;
> > +
> > +	response = (struct vmbus_channel_modifychannel_response *)hdr;
> > +
> > +	trace_vmbus_onmodifychannel_response(response);
> > +
> > +	/*
> > +	 * Find the modify msg, copy the response and signal/unblock the wait event.
> > +	 */
> > +	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
> > +
> > +	list_for_each_entry(msginfo, &vmbus_connection.chn_msg_list, msglistentry) {
> > +		struct vmbus_channel_message_header *responseheader =
> > +				(struct vmbus_channel_message_header *)msginfo->msg;
> > +
> > +		if (responseheader->msgtype == CHANNELMSG_MODIFYCHANNEL) {
> > +			struct vmbus_channel_modifychannel *modifymsg;
> > +
> > +			modifymsg = (struct vmbus_channel_modifychannel *)msginfo->msg;
> > +			if (modifymsg->child_relid == response->child_relid) {
> > +				memcpy(&msginfo->response.modify_response, response,
> > +				       sizeof(struct vmbus_channel_modifychannel_response));
> 
> Use "sizeof(*response)" ?

Applied.


> > @@ -237,6 +238,40 @@ void hv_synic_disable_regs(unsigned int cpu)
> >  	hv_set_synic_state(sctrl.as_uint64);
> >  }
> > 
> > +#define HV_MAX_TRIES 3
> > +/*
> > + * Scan the event flags page of 'this' CPU looking for any bit that is set.  If we find one
> > + * bit set, then wait for a few milliseconds.  Repeat these steps for a maximum of 3 times.
> 
> A bit more comment here might be warranted.  If a bit is set, that means there is a
> pending channel interrupt.  The expectation is that the normal interrupt handling
> mechanism will find and process the channel interrupt "very soon", and in the process
> clear the bit.   Since Hyper-V won't be setting any additional channel interrupt bits, we
> should very soon reach a state where no bits are set.

I could add something like the above.  Some editing seems to be required
if we want it to be part of 2/3 (that is, before ACKs are introduced).
Similar consideration holds for my comment in hv_synic_cleanup() below.

Suggestions?


> 
> > + * Return 'true', if there is still any set bit after this operation; 'false', otherwise.
> > + */
> > +static bool hv_synic_event_pending(void)
> > +{
> > +	struct hv_per_cpu_context *hv_cpu = this_cpu_ptr(hv_context.cpu_context);
> > +	union hv_synic_event_flags *event =
> > +		(union hv_synic_event_flags *)hv_cpu->synic_event_page + VMBUS_MESSAGE_SINT;
> > +	unsigned long *recv_int_page = event->flags;
> 
> I think a comment is warranted here.  The similar vmbus_chan_sched() code has two ways
> to get the recv_int_page, depending on the negotiated VMbus protocol version.  This code
> assumes the "new" way to get the recv_int_page, which makes sense given that it is invoked
> only for newer VMbus protocol versions.   But a note about that assumption would be a good
> warning for future readers/coders.

I've added a comment to this effect.


> 
> > +	bool pending;
> > +	u32 relid;
> > +	int tries = 0;
> > +
> > +retry:
> > +	pending = false;
> > +	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
> > +		/* Special case - VMBus channel protocol messages */
> > +		if (relid == 0)
> > +			continue;
> > +		if (sync_test_bit(relid, recv_int_page)) {
> > +			pending = true;
> > +			break;
> 
> I'm not clear on why the above test is needed.  If the bit was found to be set
> by for_each_set_bit(), that seems good enough to set pending=true.

Agreed.  I've removed the test.

Thanks,
  Andrea
