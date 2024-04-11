Return-Path: <linux-hyperv+bounces-1960-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B38A22BA
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Apr 2024 01:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCA51C20994
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 23:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516474C601;
	Thu, 11 Apr 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f300QGH/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F524AED7;
	Thu, 11 Apr 2024 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879949; cv=none; b=cnsChIe3A44M5pc0wvjRwviVm3+Z2ZAKsTh8SxBB4TDYPvFPdf/p7uO4KhP2IoVG+kBhG0w3NCdenJQ7dpAIa04lBRID7TeNduiOCFyyuH/ibPMv0ufrsvnHDA/TYHWQtSu9lYm+VzcnMi3J2WrcA6GRvXe+fL9YG0G11pH9nUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879949; c=relaxed/simple;
	bh=b//RKHovZbqzT97pXQjntBhSf52CDLggWoSaID8uD+Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GWge52UCxtX+qV6ITHR0xK86V/YC9iywingRLq9tjipxPmCZ5e4LpHQ94K76sxaeOsOh7GyQEcWqLz6QmhljTVBlaOd5dV8D8xLb1MMk8rpK61qdml2zgu/sWmxuqFZQT8MKGrpd7dWvsxzBNCSgFffBopkCxgJ/D2OVzFhRFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f300QGH/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C315C20EC318;
	Thu, 11 Apr 2024 16:59:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C315C20EC318
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712879946;
	bh=9kUmUd7b7xULaANHlY2Onsl5tXnPOYpQhSBmf0Vzi/Y=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=f300QGH/7zyTE57KVxxoppUQ9aMBrpfr98or9w9eJhI/teA2mwtnydPJaQ2IB4dMy
	 5Mzkixzlita63CpzaGaeqAvJgWj/tAEi6vZh7bHgfi3PAvDWCnI3OMGkn1dPZbPzcq
	 rNxQklzLcYDAh3A0gWwETr16BkAOiQXffYHYl5kI=
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v2 1/2] hyperv: Convert from tasklet to BH workqueue
From: Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157085E3111E1C251168ED2D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 11 Apr 2024 16:58:56 -0700
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADA89F4D-5789-44BF-A4C6-3003F8B95A20@linux.microsoft.com>
References: <20240403165542.21738-1-apais@linux.microsoft.com>
 <SN6PR02MB4157085E3111E1C251168ED2D4062@SN6PR02MB4157.namprd02.prod.outlook.com>
To: Michael Kelley <mhklinux@outlook.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Apr 10, 2024, at 11:08=E2=80=AFAM, Michael Kelley =
<mhklinux@outlook.com> wrote:
>=20
> From: Allen Pais <apais@linux.microsoft.com> Sent: Wednesday, April 3, =
2024 9:56 AM
>>=20
>> The only generic interface to execute asynchronously in the BH =
context is
>> tasklet; however, it's marked deprecated and has some design flaws. =
To
>> replace tasklets, BH workqueue support was recently added. A BH =
workqueue
>> behaves similarly to regular workqueues except that the queued work =
items
>> are executed in the BH context.
>>=20
>> This patch converts drivers/hv/* from tasklet to BH workqueue.
>>=20
>> Based on the work done by Tejun Heo <tj@kernel.org>
>> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git =
for-6.10
>>=20
>> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
>> ---
>> drivers/hv/channel.c      |  8 ++++----
>> drivers/hv/channel_mgmt.c |  5 ++---
>> drivers/hv/connection.c   |  9 +++++----
>> drivers/hv/hv.c           |  3 +--
>> drivers/hv/hv_balloon.c   |  4 ++--
>> drivers/hv/hv_fcopy.c     |  8 ++++----
>> drivers/hv/hv_kvp.c       |  8 ++++----
>> drivers/hv/hv_snapshot.c  |  8 ++++----
>> drivers/hv/hyperv_vmbus.h |  9 +++++----
>> drivers/hv/vmbus_drv.c    | 20 +++++++++++---------
>> include/linux/hyperv.h    |  2 +-
>> 11 files changed, 43 insertions(+), 41 deletions(-)
>>=20
>> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
>> index adbf674355b2..876d78eb4dce 100644
>> --- a/drivers/hv/channel.c
>> +++ b/drivers/hv/channel.c
>> @@ -859,7 +859,7 @@ void vmbus_reset_channel_cb(struct vmbus_channel
>> *channel)
>> 	unsigned long flags;
>>=20
>> 	/*
>> -	 * vmbus_on_event(), running in the per-channel tasklet, can =
race
>> +	 * vmbus_on_event(), running in the per-channel work, can race
>> 	 * with vmbus_close_internal() in the case of SMP guest, e.g., =
when
>> 	 * the former is accessing channel->inbound.ring_buffer, the =
latter
>> 	 * could be freeing the ring_buffer pages, so here we must stop =
it
>> @@ -871,7 +871,7 @@ void vmbus_reset_channel_cb(struct vmbus_channel =
*channel)
>> 	 * and that the channel ring buffer is no longer being accessed, =
cf.
>> 	 * the calls to napi_disable() in netvsc_device_remove().
>> 	 */
>> -	tasklet_disable(&channel->callback_event);
>> +	disable_work_sync(&channel->callback_event);
>>=20
>> 	/* See the inline comments in vmbus_chan_sched(). */
>> 	spin_lock_irqsave(&channel->sched_lock, flags);
>> @@ -880,8 +880,8 @@ void vmbus_reset_channel_cb(struct vmbus_channel =
*channel)
>>=20
>> 	channel->sc_creation_callback =3D NULL;
>>=20
>> -	/* Re-enable tasklet for use on re-open */
>> -	tasklet_enable(&channel->callback_event);
>> +	/* Re-enable work for use on re-open */
>> +	enable_and_queue_work(system_bh_wq, &channel->callback_event);
>=20
> In this case and in several other cases in the Hyper-V related code, =
you've
> used enable_and_queue_work() as the replacement for tasklet_enable().
> I would have expected just enable_work() as the equivalent.  =
tasklet_enable()
> just re-enables the tasklet; it does not do tasklet_schedule().

 Thank you. I see your point. Let me update the call accordingly and =
send out
A new version.

>=20
> Doing the additional queue_work() shouldn't break anything; the work
> function will run and find nothing to do, which is benign.  But it =
seems
> conceptually wrong to have these places in the code queueing the work
> to run.

Okay.

>=20
> Other than that, the code looks good to me.  I can see that there's
> considerably more overhead in using a workqueue instead of a
> tasklet.  Tasklets access with only per-CPU data and have no spin =
locks,
> whereas the workqueue code reads some global data and does
> a spin lock obtain/release on per-CPU data.  I haven't done any
> perf testing, and won't be able to at least over the next week. But
> the key scenario will be to test VMs with high CPU counts and lots
> of synthetic and/or storage interrupts.  I suspect the additional
> overhead won't be noticeable/measurable, but I agree with your
> initial statement that this should be checked.

 I will try and grab hold of a vm with high CPU count and run some =
tests.
Thanks for the quick review.

- Allen

>=20
> Michael
>=20
>> }
>>=20
>> static int vmbus_close_internal(struct vmbus_channel *channel)
>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> index 2f4d09ce027a..58397071a0de 100644
>> --- a/drivers/hv/channel_mgmt.c
>> +++ b/drivers/hv/channel_mgmt.c
>> @@ -353,8 +353,7 @@ static struct vmbus_channel *alloc_channel(void)
>>=20
>> 	INIT_LIST_HEAD(&channel->sc_list);
>>=20
>> -	tasklet_init(&channel->callback_event,
>> -		     vmbus_on_event, (unsigned long)channel);
>> +	INIT_WORK(&channel->callback_event, vmbus_on_event);
>>=20
>> 	hv_ringbuffer_pre_init(channel);
>>=20
>> @@ -366,7 +365,7 @@ static struct vmbus_channel *alloc_channel(void)
>>  */
>> static void free_channel(struct vmbus_channel *channel)
>> {
>> -	tasklet_kill(&channel->callback_event);
>> +	cancel_work_sync(&channel->callback_event);
>> 	vmbus_remove_channel_attr_group(channel);
>>=20
>> 	kobject_put(&channel->kobj);
>> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
>> index 3cabeeabb1ca..f2a3394a8303 100644
>> --- a/drivers/hv/connection.c
>> +++ b/drivers/hv/connection.c
>> @@ -372,12 +372,13 @@ struct vmbus_channel *relid2channel(u32 relid)
>>  * 3. Once we return, enable signaling from the host. Once this
>>  *    state is set we check to see if additional packets are
>>  *    available to read. In this case we repeat the process.
>> - *    If this tasklet has been running for a long time
>> + *    If this work has been running for a long time
>>  *    then reschedule ourselves.
>>  */
>> -void vmbus_on_event(unsigned long data)
>> +void vmbus_on_event(struct work_struct *t)
>> {
>> -	struct vmbus_channel *channel =3D (void *) data;
>> +	struct vmbus_channel *channel =3D from_work(channel, t,
>> +						callback_event);
>> 	void (*callback_fn)(void *context);
>>=20
>> 	trace_vmbus_on_event(channel);
>> @@ -401,7 +402,7 @@ void vmbus_on_event(unsigned long data)
>> 		return;
>>=20
>> 	hv_begin_read(&channel->inbound);
>> -	tasklet_schedule(&channel->callback_event);
>> +	queue_work(system_bh_wq, &channel->callback_event);
>> }
>>=20
>> /*
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index a8ad728354cb..2af92f08f9ce 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -119,8 +119,7 @@ int hv_synic_alloc(void)
>> 	for_each_present_cpu(cpu) {
>> 		hv_cpu =3D per_cpu_ptr(hv_context.cpu_context, cpu);
>>=20
>> -		tasklet_init(&hv_cpu->msg_dpc,
>> -			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
>> +		INIT_WORK(&hv_cpu->msg_dpc, vmbus_on_msg_dpc);
>>=20
>> 		if (ms_hyperv.paravisor_present && =
hv_isolation_type_tdx())
>> {
>> 			hv_cpu->post_msg_page =3D (void =
*)get_zeroed_page(GFP_ATOMIC);
>> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
>> index e000fa3b9f97..c7efa2ff4cdf 100644
>> --- a/drivers/hv/hv_balloon.c
>> +++ b/drivers/hv/hv_balloon.c
>> @@ -2083,7 +2083,7 @@ static int balloon_suspend(struct hv_device =
*hv_dev)
>> {
>> 	struct hv_dynmem_device *dm =3D hv_get_drvdata(hv_dev);
>>=20
>> -	tasklet_disable(&hv_dev->channel->callback_event);
>> +	disable_work_sync(&hv_dev->channel->callback_event);
>>=20
>> 	cancel_work_sync(&dm->balloon_wrk.wrk);
>> 	cancel_work_sync(&dm->ha_wrk.wrk);
>> @@ -2094,7 +2094,7 @@ static int balloon_suspend(struct hv_device =
*hv_dev)
>> 		vmbus_close(hv_dev->channel);
>> 	}
>>=20
>> -	tasklet_enable(&hv_dev->channel->callback_event);
>> +	enable_and_queue_work(system_bh_wq, =
&hv_dev->channel->callback_event);
>>=20
>> 	return 0;
>>=20
>> diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
>> index 922d83eb7ddf..fd6799293c17 100644
>> --- a/drivers/hv/hv_fcopy.c
>> +++ b/drivers/hv/hv_fcopy.c
>> @@ -71,7 +71,7 @@ static void fcopy_poll_wrapper(void *channel)
>> {
>> 	/* Transaction is finished, reset the state here to avoid races. =
*/
>> 	fcopy_transaction.state =3D HVUTIL_READY;
>> -	tasklet_schedule(&((struct vmbus_channel =
*)channel)->callback_event);
>> +	queue_work(system_bh_wq, &((struct vmbus_channel =
*)channel)->callback_event);
>> }
>>=20
>> static void fcopy_timeout_func(struct work_struct *dummy)
>> @@ -391,7 +391,7 @@ int hv_fcopy_pre_suspend(void)
>> 	if (!fcopy_msg)
>> 		return -ENOMEM;
>>=20
>> -	tasklet_disable(&channel->callback_event);
>> +	disable_work_sync(&channel->callback_event);
>>=20
>> 	fcopy_msg->operation =3D CANCEL_FCOPY;
>>=20
>> @@ -404,7 +404,7 @@ int hv_fcopy_pre_suspend(void)
>>=20
>> 	fcopy_transaction.state =3D HVUTIL_READY;
>>=20
>> -	/* tasklet_enable() will be called in hv_fcopy_pre_resume(). */
>> +	/* enable_and_queue_work(system_bh_wq, ) will be called in =
hv_fcopy_pre_resume(). */
>> 	return 0;
>> }
>>=20
>> @@ -412,7 +412,7 @@ int hv_fcopy_pre_resume(void)
>> {
>> 	struct vmbus_channel *channel =3D =
fcopy_transaction.recv_channel;
>>=20
>> -	tasklet_enable(&channel->callback_event);
>> +	enable_and_queue_work(system_bh_wq, &channel->callback_event);
>>=20
>> 	return 0;
>> }
>> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
>> index d35b60c06114..85b8fb4a3d2e 100644
>> --- a/drivers/hv/hv_kvp.c
>> +++ b/drivers/hv/hv_kvp.c
>> @@ -113,7 +113,7 @@ static void kvp_poll_wrapper(void *channel)
>> {
>> 	/* Transaction is finished, reset the state here to avoid races. =
*/
>> 	kvp_transaction.state =3D HVUTIL_READY;
>> -	tasklet_schedule(&((struct vmbus_channel =
*)channel)->callback_event);
>> +	queue_work(system_bh_wq, &((struct vmbus_channel =
*)channel)->callback_event);
>> }
>>=20
>> static void kvp_register_done(void)
>> @@ -160,7 +160,7 @@ static void kvp_timeout_func(struct work_struct =
*dummy)
>>=20
>> static void kvp_host_handshake_func(struct work_struct *dummy)
>> {
>> -	tasklet_schedule(&kvp_transaction.recv_channel->callback_event);
>> +	queue_work(system_bh_wq, =
&kvp_transaction.recv_channel->callback_event);
>> }
>>=20
>> static int kvp_handle_handshake(struct hv_kvp_msg *msg)
>> @@ -786,7 +786,7 @@ int hv_kvp_pre_suspend(void)
>> {
>> 	struct vmbus_channel *channel =3D kvp_transaction.recv_channel;
>>=20
>> -	tasklet_disable(&channel->callback_event);
>> +	disable_work_sync(&channel->callback_event);
>>=20
>> 	/*
>> 	 * If there is a pending transtion, it's unnecessary to tell the =
host
>> @@ -809,7 +809,7 @@ int hv_kvp_pre_resume(void)
>> {
>> 	struct vmbus_channel *channel =3D kvp_transaction.recv_channel;
>>=20
>> -	tasklet_enable(&channel->callback_event);
>> +	enable_and_queue_work(system_bh_wq, &channel->callback_event);
>>=20
>> 	return 0;
>> }
>> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
>> index 0d2184be1691..46c2263d2591 100644
>> --- a/drivers/hv/hv_snapshot.c
>> +++ b/drivers/hv/hv_snapshot.c
>> @@ -83,7 +83,7 @@ static void vss_poll_wrapper(void *channel)
>> {
>> 	/* Transaction is finished, reset the state here to avoid races. =
*/
>> 	vss_transaction.state =3D HVUTIL_READY;
>> -	tasklet_schedule(&((struct vmbus_channel =
*)channel)->callback_event);
>> +	queue_work(system_bh_wq, &((struct vmbus_channel =
*)channel)->callback_event);
>> }
>>=20
>> /*
>> @@ -421,7 +421,7 @@ int hv_vss_pre_suspend(void)
>> 	if (!vss_msg)
>> 		return -ENOMEM;
>>=20
>> -	tasklet_disable(&channel->callback_event);
>> +	disable_work_sync(&channel->callback_event);
>>=20
>> 	vss_msg->vss_hdr.operation =3D VSS_OP_THAW;
>>=20
>> @@ -435,7 +435,7 @@ int hv_vss_pre_suspend(void)
>>=20
>> 	vss_transaction.state =3D HVUTIL_READY;
>>=20
>> -	/* tasklet_enable() will be called in hv_vss_pre_resume(). */
>> +	/* enable_and_queue_work() will be called in =
hv_vss_pre_resume(). */
>> 	return 0;
>> }
>>=20
>> @@ -443,7 +443,7 @@ int hv_vss_pre_resume(void)
>> {
>> 	struct vmbus_channel *channel =3D vss_transaction.recv_channel;
>>=20
>> -	tasklet_enable(&channel->callback_event);
>> +	enable_and_queue_work(system_bh_wq, &channel->callback_event);
>>=20
>> 	return 0;
>> }
>> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
>> index f6b1e710f805..95ca570ac7af 100644
>> --- a/drivers/hv/hyperv_vmbus.h
>> +++ b/drivers/hv/hyperv_vmbus.h
>> @@ -19,6 +19,7 @@
>> #include <linux/atomic.h>
>> #include <linux/hyperv.h>
>> #include <linux/interrupt.h>
>> +#include <linux/workqueue.h>
>>=20
>> #include "hv_trace.h"
>>=20
>> @@ -136,10 +137,10 @@ struct hv_per_cpu_context {
>>=20
>> 	/*
>> 	 * Starting with win8, we can take channel interrupts on any =
CPU;
>> -	 * we will manage the tasklet that handles events messages on a =
per CPU
>> +	 * we will manage the work that handles events messages on a per =
CPU
>> 	 * basis.
>> 	 */
>> -	struct tasklet_struct msg_dpc;
>> +	struct work_struct msg_dpc;
>> };
>>=20
>> struct hv_context {
>> @@ -366,8 +367,8 @@ void vmbus_disconnect(void);
>>=20
>> int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep);
>>=20
>> -void vmbus_on_event(unsigned long data);
>> -void vmbus_on_msg_dpc(unsigned long data);
>> +void vmbus_on_event(struct work_struct *t);
>> +void vmbus_on_msg_dpc(struct work_struct *t);
>>=20
>> int hv_kvp_init(struct hv_util_service *srv);
>> void hv_kvp_deinit(void);
>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>> index 4cb17603a828..28490068cacc 100644
>> --- a/drivers/hv/vmbus_drv.c
>> +++ b/drivers/hv/vmbus_drv.c
>> @@ -1025,9 +1025,9 @@ static void vmbus_onmessage_work(struct =
work_struct *work)
>> 	kfree(ctx);
>> }
>>=20
>> -void vmbus_on_msg_dpc(unsigned long data)
>> +void vmbus_on_msg_dpc(struct work_struct *t)
>> {
>> -	struct hv_per_cpu_context *hv_cpu =3D (void *)data;
>> +	struct hv_per_cpu_context *hv_cpu =3D from_work(hv_cpu, t, =
msg_dpc);
>> 	void *page_addr =3D hv_cpu->synic_message_page;
>> 	struct hv_message msg_copy, *msg =3D (struct hv_message =
*)page_addr +
>> 				  VMBUS_MESSAGE_SINT;
>> @@ -1131,7 +1131,7 @@ void vmbus_on_msg_dpc(unsigned long data)
>> 			 * before sending the rescind message of the =
same
>> 			 * channel.  These messages are sent to the =
guest's
>> 			 * connect CPU; the guest then starts processing =
them
>> -			 * in the tasklet handler on this CPU:
>> +			 * in the work handler on this CPU:
>> 			 *
>> 			 * VMBUS_CONNECT_CPU
>> 			 *
>> @@ -1276,7 +1276,7 @@ static void vmbus_chan_sched(struct =
hv_per_cpu_context *hv_cpu)
>> 			hv_begin_read(&channel->inbound);
>> 			fallthrough;
>> 		case HV_CALL_DIRECT:
>> -			tasklet_schedule(&channel->callback_event);
>> +			queue_work(system_bh_wq, =
&channel->callback_event);
>> 		}
>>=20
>> sched_unlock:
>> @@ -1304,7 +1304,7 @@ static void vmbus_isr(void)
>> 			hv_stimer0_isr();
>> 			vmbus_signal_eom(msg, HVMSG_TIMER_EXPIRED);
>> 		} else
>> -			tasklet_schedule(&hv_cpu->msg_dpc);
>> +			queue_work(system_bh_wq, &hv_cpu->msg_dpc);
>> 	}
>>=20
>> 	add_interrupt_randomness(vmbus_interrupt);
>> @@ -2371,10 +2371,12 @@ static int vmbus_bus_suspend(struct device =
*dev)
>> 			hv_context.cpu_context, VMBUS_CONNECT_CPU);
>> 	struct vmbus_channel *channel, *sc;
>>=20
>> -	tasklet_disable(&hv_cpu->msg_dpc);
>> +	disable_work_sync(&hv_cpu->msg_dpc);
>> 	vmbus_connection.ignore_any_offer_msg =3D true;
>> -	/* The tasklet_enable() takes care of providing a memory barrier =
*/
>> -	tasklet_enable(&hv_cpu->msg_dpc);
>> +	/* The enable_and_queue_work() takes care of
>> +	 * providing a memory barrier
>> +	 */
>> +	enable_and_queue_work(system_bh_wq, &hv_cpu->msg_dpc);
>>=20
>> 	/* Drain all the workqueues as we are in suspend */
>> 	drain_workqueue(vmbus_connection.rescind_work_queue);
>> @@ -2692,7 +2694,7 @@ static void __exit vmbus_exit(void)
>> 		struct hv_per_cpu_context *hv_cpu
>> 			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>>=20
>> -		tasklet_kill(&hv_cpu->msg_dpc);
>> +		cancel_work_sync(&hv_cpu->msg_dpc);
>> 	}
>> 	hv_debug_rm_all_dir();
>>=20
>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>> index 6ef0557b4bff..db3d85ea5ce6 100644
>> --- a/include/linux/hyperv.h
>> +++ b/include/linux/hyperv.h
>> @@ -882,7 +882,7 @@ struct vmbus_channel {
>> 	bool out_full_flag;
>>=20
>> 	/* Channel callback's invoked in softirq context */
>> -	struct tasklet_struct callback_event;
>> +	struct work_struct callback_event;
>> 	void (*onchannel_callback)(void *context);
>> 	void *channel_callback_context;
>>=20
>> --
>> 2.17.1
>>=20


