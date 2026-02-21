Return-Path: <linux-hyperv+bounces-8936-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +6f1LLEemWk6RAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8936-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Feb 2026 03:55:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B99016BFCD
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Feb 2026 03:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1921300373A
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Feb 2026 02:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F431A551;
	Sat, 21 Feb 2026 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="fkFcMFMa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E07E792;
	Sat, 21 Feb 2026 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771642537; cv=pass; b=d+bgkAmTIZcNKAJ3xSwNiwPR9POser6/WJwMQVYmQIq+A77CebY/+Hky6jX1kn2I+b1TOQLR9jzJ915+2FwpsqT+Epa4mq+S/N0sc6c4frtId83wn9TsBB/JH0Hg2m8tm/ZMDxQZfuEmSq3dEZEqXYhalXPFTvTvWEc+AAuX++g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771642537; c=relaxed/simple;
	bh=8QsW+8QWvMTYnv8gC8jwAiKkcxVXZ7vSrC80UZy/QwI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=plPDuMbMVXEu/oj5zquazuN2L+bajQxRsT8o8sVboAuwHgcY0D+EyCmyqPJISt+R/zhh3R6UBBp2qOEqdZF/haLwuKxIzylpariK4pCJnI8lXTraPIguJcRFlPD9c1gbsJ69egbkAqJWFe9eNQ2EAmAndv0elMP/w5qE+cecFTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=fkFcMFMa; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1771642520; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q3BDp+4gu2dFXmXc1OI1x+i6Q9tHl0qu+dK9PX7g8XWZR0sLiIs3qfdr7WXQT5ZCLmq2/tfQuHn9jisRYeoN3bKJ1gLG1zF83Q9dcrenGYPYvOOiqfpHozExyLRbPc26KxGpNRplwwEPwQeqiZjmwtztwqM4sprk91HbwdXE1rE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771642520; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kAj1wuwyAAs08zW23cak0NopjszksiabwPLO2bTKHyc=; 
	b=J8qp0ekD8utKB0pfUHbtmj2oVCzfXzI4bCNoR2TM0tAbj3MWvHQovKnS/CoFrZkhAXpcKz2VguUxMdbbYshuRq5IjdzDCc4yPsyqV7OIY83sVB7U6NcBl4S6NcL1o7AzC3k4SQUYOriz0CnGoFgOqzwMsw2fVe4Vh7YDTCII6as=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771642519;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:References:In-Reply-To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=kAj1wuwyAAs08zW23cak0NopjszksiabwPLO2bTKHyc=;
	b=fkFcMFMaogjuDaHJpdwKlneK4vJBDLPcPU2vMfoI29xJxUoxzs+anm+/01Gm6UMj
	zZGCV37c5p9JcrSqzDI3LDBVR5w2PjuMXm189n5x4IS5+71KDI+l/ZdKiLhE1oJKCr8
	YJGW7/gIf/O8esSt5ZMcfRfti9B65boaOZCpOnEw=
Received: by mx.zohomail.com with SMTPS id 1771642518922720.5191555832141;
	Fri, 20 Feb 2026 18:55:18 -0800 (PST)
From: <mhklkml@zohomail.com>
To: <vdso@mailbox.org>,
	<mhklinux@outlook.com>
Cc: <linux-kernel@vger.kernel.org>,
	<kys@microsoft.com>,
	<wei.liu@kernel.org>,
	<haiyangz@microsoft.com>,
	<longli@microsoft.com>,
	<decui@microsoft.com>,
	<linux-hyperv@vger.kernel.org>
References: <20260220164045.1670-1-mhklkml@zohomail.com> <1554036576.472972.1771638469213@app.mailbox.org>
In-Reply-To: <1554036576.472972.1771638469213@app.mailbox.org>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Limit channel interrupt scan to relid high water mark
Date: Fri, 20 Feb 2026 18:55:17 -0800
Message-ID: <01bb01dca2dd$833a4b20$89aee160$@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQLVHRIVvggES5zdtATCDTfbK2PZhwHsbUM8s4wbCnA=
Feedback-ID: rr080112270a182d0abe0e1bfab48e7c250000145244e8dc250ddf3a3c1a9b40526d0dd46c687a91ee36da58:zu080112277a5b151368440073ea8ff277000004ee3148fae7ca5e85246d557eb94e2ca6af760b5b2a2c61fa:rf0801122668a2a89b93484be1d0a304f40000ee6e77b5ceb8656f009904f680d537533f531be78f93c86d:ZohoMail
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8936-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[zohomail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[mailbox.org,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,zohomail.com:mid,zohomail.com:dkim,zohomail.com:email]
X-Rspamd-Queue-Id: 4B99016BFCD
X-Rspamd-Action: no action

From: vdso@mailbox.org <vdso@mailbox.org> Sent: Friday, February 20, =
2026 5:48 PM
>
> Hi Michael,
>=20
> Boots for me on an x86_64 machine. Got a typo fix and a question for =
you.
> Tagging as reviewed and tested regardless :)
>=20
> > On 02/20/2026 8:40 AM  Michael Kelley <mhklkml@zohomail.com> wrote:
> >
> >
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > When checking for VMBus channel interrutps, current code always =
scans the
>=20
> /s/interrutps/interrupts
>=20
> > full SynIC receive interrupt bit array to get the relid of the
> > interrupting channels. The array has HV_EVENT_FLAGS_COUNT (2048) =
bits.
> > But VMs rarely have more than 100 channels, and the relid is =
typically
> > a small integer that is densely assigned by the Hyper-V host. It's
> > wasteful to scan 2048 bits when it is highly unlikely that anything =
will
> > be found past bit 100. The waste is double with Confidential VMBus =
because
> > there are two receive interrupt arrays that must be scanned: one for =
the
> > hypervisor SynIC and one for the paravisor SynIC.
> >
> > Improve the scanning by tracking the largest relid that has been =
offered
> > by the Hyper-V host. Then when checking for VMBus channel =
interrupts, only
> > scan up to this high water mark.
> >
> > When channels are rescinded, it's not worth the complexity to =
recalculate
> > the high water mark. Hyper-V tends to reuse the rescinded relids for =
any
> > new channels that are subsequently added, and the performance =
benefit of
> > exactly tracking the high water mark would be minimal.
> >
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>=20
> Tested-by: Roman Kisel <vdso@mailbox.org>
> Reviewed-by: Roman Kisel <vdso@mailbox.org>

Thanks!

>=20
> > ---
> >  drivers/hv/channel_mgmt.c | 16 ++++++++++++----
> >  drivers/hv/hyperv_vmbus.h |  3 ++-
> >  drivers/hv/vmbus_drv.c    |  7 +------
> >  3 files changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 74fed2c073d4..61f7dffd0f50 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -384,8 +384,18 @@ static void free_channel(struct vmbus_channel =
*channel)
> >
> >  void vmbus_channel_map_relid(struct vmbus_channel *channel)
> >  {
> > -	if (WARN_ON(channel->offermsg.child_relid >=3D =
MAX_CHANNEL_RELIDS))
> > +	u32 new_relid =3D channel->offermsg.child_relid;
> > +
> > +	if (WARN_ON(new_relid >=3D MAX_CHANNEL_RELIDS))
> >  		return;
> > +
> > +	/*
> > +	 * This function is always called in the tasklet for the connect =
CPU.
> > +	 * So updating the relid hiwater mark does not need to be atomic.
> > +	 */
> > +	if (new_relid > READ_ONCE(vmbus_connection.relid_hiwater))
> > +		WRITE_ONCE(vmbus_connection.relid_hiwater, new_relid);
> > +
> >  	/*
> >  	 * The mapping of the channel's relid is visible from the CPUs =
that
> >  	 * execute vmbus_chan_sched() by the time that vmbus_chan_sched() =
will
> > @@ -411,9 +421,7 @@ void vmbus_channel_map_relid(struct =
vmbus_channel *channel)
> >  	 *      of the VMBus driver and vmbus_chan_sched() can not run =
before
> >  	 *      vmbus_bus_resume() has completed execution (cf. =
resume_noirq).
> >  	 */
> > -	virt_store_mb(
> > -		vmbus_connection.channels[channel->offermsg.child_relid],
> > -		channel);
> > +	virt_store_mb(vmbus_connection.channels[new_relid], channel);
> >  }
> >
> >  void vmbus_channel_unmap_relid(struct vmbus_channel *channel)
> > diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> > index 7bd8f8486e85..2c90c81a3b0f 100644
> > --- a/drivers/hv/hyperv_vmbus.h
> > +++ b/drivers/hv/hyperv_vmbus.h
> > @@ -276,8 +276,9 @@ struct vmbus_connection {
> >  	struct list_head chn_list;
> >  	struct mutex channel_mutex;
> >
> > -	/* Array of channels */
> > +	/* Array of channel pointers, indexed by relid */
> >  	struct vmbus_channel **channels;
> > +	u32 relid_hiwater;
> >
> >  	/*
> >  	 * An offer message is handled first on the work_queue, and then
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 3e7a52918ce0..a96da105b593 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1258,17 +1258,12 @@ static void vmbus_chan_sched(void =
*event_page_addr)
> >  		return;
> >  	event =3D (union hv_synic_event_flags *)event_page_addr + =
VMBUS_MESSAGE_SINT;
> >
> > -	maxbits =3D HV_EVENT_FLAGS_COUNT;
> > +	maxbits =3D READ_ONCE(vmbus_connection.relid_hiwater) + 1;
>=20
> Worth checking that "maxbits <=3D HV_EVENT_FLAGS_COUNT" to protect =
from
> corruptions, etc. or would be too paranoidal?

We definitely want to validate what Hyper-V returns to the guest as a =
relid,
and drop any values that are "too big", so we don't go indexing off into
bogus memory. But that validation is done in vmbus_channel_map_relid()
with a WARN_ON() before setting relid_hiwater.  So there's no way for
relid_hiwater to be bogus, and additional validation here in
vmbus_chan_sched() really isn't necessary.

Michael

>=20
> >  	recv_int_page =3D event->flags;
> >
> >  	if (unlikely(!recv_int_page))
> >  		return;
> >
> > -	/*
> > -	 * Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > -	 * One possible optimization would be to keep track of the largest =
relID that's in use,
> > -	 * and only scan up to that relID.
> > -	 */
> >  	for_each_set_bit(relid, recv_int_page, maxbits) {
> >  		void (*callback_fn)(void *context);
> >  		struct vmbus_channel *channel;
> > --
> > 2.25.1



