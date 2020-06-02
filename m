Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC81EC605
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2020 02:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgFCAC1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Jun 2020 20:02:27 -0400
Received: from mail-mw2nam10on2135.outbound.protection.outlook.com ([40.107.94.135]:25409
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbgFCAC0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Jun 2020 20:02:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CearsWTjLkRtPoOwdgEtOU8YLEP3nLCDByrgpGPtT/4Aq/WiFrB+WGPecS3Z54XkgqjMS0dy6KEvFmYYbwFtnns/sN6rD2onFuSPQGPWHVyKvdmlklwP771VTBVmewkp40/uFSkKKnYis1OrL56OPOYHEIqI6DpnFmjSYAldGk1GJSvYbcCv+CmQGYxzBXLpYapCOCitH6HkYiZrFJRJxetHGK3+dQ36YboUIYM/AmFOmLRRP4Ixg6IAOMDjHWJ9REjOy5Pc7Q8CA5JzJUH9cjSAjd38ST7/1Qlip1mBOsUrYmMwsCkxDXii6RzegQXYwqXOsHvqz2AVZVFS0WTYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuQWXc0vBjgH4VwkPJNEll6sb94mDHDc6NaziRZvWHM=;
 b=dPet1TPpUNXvg1iVWrZ5Yj9j1KthZHTbPku3XNzFIbFFS9PBifXAVSHqK4Xp088nLGdDiqnOCa4tFqmz+Y6aJ6FSMnrqFlba5T0CELuvsdZGM8B6LuTb/wif7upNBXMKsv/ELx4WFzI4hJFQx/CQL9HojHpUy0Qy1G6AmGuc+7PMUH4QOwQhOrv2Fk/CqEGBHZJEtQyUvP5HKv1hmDFf6ZRIx0lW57rx2diFTq44dBK91AQLeFyFJYQXb3zOnWwxa2yiCTbjKoPBNufSAQPKeTMBU39cEVKQo3Ss0N3HJgGgF3jlW34ghOE8kEOZKNpcNRAUg/43GSlZwSnDDbixlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuQWXc0vBjgH4VwkPJNEll6sb94mDHDc6NaziRZvWHM=;
 b=U+XsPKs4kEno0aVrtgvZrevETRBuDBb9Xu2FMj0+z66eX5QOCm12UcnxcKtrKYU0HSYCir7qVpJS/N9bnXCa7wQnllJFVwvornSwUFbkP4LnuQgNjHLsxMxg6V3X/JXJ6dTbPRjzqllsHPjVzXXyEwcO5R3og33NJkrJ81mcTps=
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com (2603:10b6:805:6::17)
 by SN6PR2101MB1726.namprd21.prod.outlook.com (2603:10b6:805:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.3; Tue, 2 Jun
 2020 23:47:18 +0000
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::bd27:8a86:4916:f5af]) by SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::bd27:8a86:4916:f5af%3]) with mapi id 15.20.3066.016; Tue, 2 Jun 2020
 23:47:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <Nuno.Das@microsoft.com>
Subject: RE: [RFC PATCH 1/2] Drivers: hv: vmbus: Re-balance channel interrupts
 across CPUs at CPU hotplug
Thread-Topic: [RFC PATCH 1/2] Drivers: hv: vmbus: Re-balance channel
 interrupts across CPUs at CPU hotplug
Thread-Index: AQHWM62fW79VTGPn0EKY/fE011XRo6i/7/wA
Date:   Tue, 2 Jun 2020 23:47:17 +0000
Message-ID: <SN6PR2101MB10562BB7B20846C8C711F2DDD78B0@SN6PR2101MB1056.namprd21.prod.outlook.com>
References: <20200526223218.184057-1-parri.andrea@gmail.com>
 <20200526223218.184057-2-parri.andrea@gmail.com>
In-Reply-To: <20200526223218.184057-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-02T23:47:15Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5496c75f-2069-4268-8b70-3e3d8305c48d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b759f2d-6583-4713-7f50-08d8074f4901
x-ms-traffictypediagnostic: SN6PR2101MB1726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB1726A73D8687BAD7375769BFD78B0@SN6PR2101MB1726.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5WVZvd/+mP09GoD/E9QiVQix6bVgZPurt3MB7Z7p53xdt45881KacoJ5K9eQAOuLrj4UxJuQ2yrH2tvDLt+evzlkpM7DJn08YJktMgw4lFG2QqAknV10IJN+u0XpkQeaZPJHQU7CC0jBEWf0IavCHyolN12zrtlALFKwFQ3uJsVG2o34kYgE0Q8mi7gEUdm8cbcuvDtQ2RkO18uSnBepL2sHdlGPWaOCnqWJzmbNMAQ0GtXB8oS+Ll+dOA2bxndI5cL843sNGBlfsJCU7KmGbDSoFUBXIsRLDxw7SM1c9COcwRdOjV+J5dRrKqdwCouXTJ0qzE20pMerSH61npL/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1056.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(54906003)(9686003)(76116006)(66946007)(107886003)(66476007)(64756008)(10290500003)(55016002)(66446008)(83380400001)(110136005)(52536014)(66556008)(5660300002)(478600001)(71200400001)(7696005)(82960400001)(82950400001)(26005)(8936002)(30864003)(2906002)(186003)(316002)(4326008)(6506007)(33656002)(86362001)(8676002)(8990500004)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uYe6JWVFbIwXkBq9C0Nu8yOg1tFdhQmQwx+JmilHZVmB2Jvmgi4GR1vYENS+uglE1yj9srbfDbpt6oS/OAqGhcVZelKtIGkusdLzL4wz7wXDJ/PrGgtmrw6pNOEC7k9+BkBIYsV/nRQQW/0w4a/m1q8gPJbyFoRRaM1SnJcK7EUaIfiUJsHnnr7rJu5yKdFjnibVdFusjgiUznTwDk5kvGbVzm5MDdc5KNdaDW2y9XENRUav8GqHxX1nZ79jOYfai6jmsZkTp+S6P5WcmlHUm+ZMRN8syv2HSCvzMrAu5pP3KgT96+ZyM55UzX9aUHHAp6jC+5SmSjmVwm0ZzLxjvhKoVuygIaIp1qdr/OIM7VTZqLI57hCPvTxc2zAeZI/eab6bP/TFqeKTJ39UOkZdYXU5EkgRUN6Zq5jaZmVm+V0cUHH3/UqF5F96iLVN9PRwdtxpV/d9BecvkqV/1IWfm07AJz+fAKl20cRiK84dUIzAOWOXhG5u9LBSuJFQBUms
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b759f2d-6583-4713-7f50-08d8074f4901
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 23:47:18.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3Tx6pqYpFYh94OrrmNVf2nf1Kh4RKT8xB/2wcQg2NseQWc8YLQcWiQzPo6CaqAecxfGvGhNNmvyIWL4JnkMLqZMFZuDBB+UXU5CRlz1d7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1726
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, May =
26, 2020 3:32 PM
>=20
> CPU hot removals and additions present an opportunity for (re-)balancing
> the channel interrupts across the available CPUs.  Current code does not
> balance the interrupts at CPU hotplug; furthermore/consequently, the hot
> removal path currently fails (to remove the specified CPU) whenever some
> interrupt is bound to the CPU to be removed and the VMBus is connected.
>=20
> Address such issues by implementing vmbus_balance_vp_indexes_at_cpuhp():
> invoke this primitive to balance the channel interrupts across available
> CPUs at CPU hotplug operations.  In the hot removal path, such primitive
> will (try to) move/balance interrupts out of the to-be-removed CPU so as
> to meet the user request to hot remove the CPU.
>=20
> The balancing algorithm distributes the channel interrupts evenly across
> the available CPUs and NUMA nodes; to do so, it introduces and maintains
> per-device and per-connection channel statistics/counts to keep track of
> the (current) assignments of the channels to the CPUs/nodes.  By design,
> only "performance"-critical channels/devices are "balanced".
>=20
> The proposed algorithm relies on the (recently introduced) capability to
> reassign a channel interrupt to a CPU (cf., the CHANNELMSG_MODIFYCHANNEL
> message type).  As such, the new balancing process is effective starting
> with VMBus version 4.1 (no changes in semantics or behavior are intended
> for VMBus versions lower than 4.1).
>=20
> Suggested-by: Nuno Das Neves <nuno.das@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c      |  38 +++++++
>  drivers/hv/channel_mgmt.c | 219 ++++++++++++++++++++++++++++++++++++++
>  drivers/hv/connection.c   |  23 ++--
>  drivers/hv/hv.c           |  62 ++++++-----
>  drivers/hv/hyperv_vmbus.h |  72 +++++++++++++
>  drivers/hv/vmbus_drv.c    |  45 +++-----
>  include/linux/hyperv.h    |  22 +++-
>  kernel/cpu.c              |   1 +
>  8 files changed, 416 insertions(+), 66 deletions(-)
>=20
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 90070b337c10d..2974aa9dc956c 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -18,6 +18,7 @@
>  #include <linux/uio.h>
>  #include <linux/interrupt.h>
>  #include <asm/page.h>
> +#include <asm/mshyperv.h>
>=20
>  #include "hyperv_vmbus.h"
>=20
> @@ -317,6 +318,43 @@ int vmbus_send_modifychannel(u32 child_relid, u32 ta=
rget_vp)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_send_modifychannel);
>=20
> +bool vmbus_modifychannel(struct vmbus_channel *channel,
> +			 u32 origin_cpu, u32 target_cpu)
> +{
> +	if (vmbus_send_modifychannel(channel->offermsg.child_relid,
> +				     hv_cpu_number_to_vp_number(target_cpu)))
> +		return false;
> +
> +	/*
> +	 * Warning.  At this point, there is *no* guarantee that the host will
> +	 * have successfully processed the vmbus_send_modifychannel() request.
> +	 * See the header comment of vmbus_send_modifychannel() for more info.
> +	 *
> +	 * Lags in the processing of the above vmbus_send_modifychannel() can
> +	 * result in missed interrupts if the "old" target CPU is taken offline
> +	 * before Hyper-V starts sending interrupts to the "new" target CPU.
> +	 * But apart from this offlining scenario, the code tolerates such
> +	 * lags.  It will function correctly even if a channel interrupt comes
> +	 * in on a CPU that is different from the channel target_cpu value.
> +	 */
> +
> +	channel->target_cpu =3D target_cpu;
> +	channel->target_vp =3D hv_cpu_number_to_vp_number(target_cpu);
> +	channel->numa_node =3D cpu_to_node(target_cpu);
> +
> +	/* See init_vp_index(). */
> +	if (hv_is_perf_channel(channel))
> +		hv_update_alloced_cpus(origin_cpu, target_cpu);
> +
> +	/* Currently set only for storvsc channels. */
> +	if (channel->change_target_cpu_callback) {
> +		(*channel->change_target_cpu_callback)(channel,
> +				origin_cpu, target_cpu);
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * create_gpadl_header - Creates a gpadl for the specified buffer
>   */
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 417a95e5094dd..c158f86787940 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -497,10 +497,14 @@ static void vmbus_add_channel_work(struct work_stru=
ct *work)
>  	/*
>  	 * Start the process of binding the primary channel to the driver
>  	 */
> +
> +	/* See vmbus_balance_vp_indexes_at_cpuhp(). */
> +	mutex_lock(&vmbus_connection.channel_mutex);
>  	newchannel->device_obj =3D vmbus_device_create(
>  		&newchannel->offermsg.offer.if_type,
>  		&newchannel->offermsg.offer.if_instance,
>  		newchannel);
> +	mutex_unlock(&vmbus_connection.channel_mutex);
>  	if (!newchannel->device_obj)
>  		goto err_deq_chan;
>=20
> @@ -515,6 +519,8 @@ static void vmbus_add_channel_work(struct work_struct=
 *work)
>  	if (ret !=3D 0) {
>  		pr_err("unable to add child device object (relid %d)\n",
>  			newchannel->offermsg.child_relid);
> +		if (hv_is_perf_channel(newchannel))
> +			free_chn_counts(&newchannel->device_obj->chn_cnt);

You could drop the "if" condition and just always call free_chn_counts() si=
nce
it will do the right thing for non-perf channels where the memory was never
allocated.

>  		kfree(newchannel->device_obj);
>  		goto err_deq_chan;
>  	}
> @@ -667,6 +673,219 @@ static void vmbus_process_offer(struct vmbus_channe=
l
> *newchannel)
>  	queue_work(wq, &newchannel->add_channel_work);
>  }
>=20
> +static void filter_on_cpus(cpumask_var_t cpu_msk,
> +			   struct vmbus_channel_counts *chn_cnt)
> +{
> +	unsigned int min_cnt =3D MAX_CHANNEL_RELIDS;
> +	unsigned int cpu;
> +
> +	for_each_cpu(cpu, cpu_msk) {
> +		unsigned int cnt =3D chn_cnt->cpu[cpu];
> +
> +		if (cnt < min_cnt)
> +			min_cnt =3D cnt;
> +	}
> +
> +	for_each_cpu(cpu, cpu_msk) {
> +		if (chn_cnt->cpu[cpu] > min_cnt)
> +			cpumask_clear_cpu(cpu, cpu_msk);
> +	}
> +}
> +
> +static void filter_on_nodes(cpumask_var_t cpu_msk,
> +			    struct vmbus_channel_counts *chn_cnt)
> +{
> +	unsigned int min_cnt =3D MAX_CHANNEL_RELIDS;
> +	unsigned int cpu;
> +
> +	for_each_cpu(cpu, cpu_msk) {
> +		unsigned int node =3D cpu_to_node(cpu);
> +		unsigned int cnt =3D chn_cnt->node[node];
> +
> +		if (cnt < min_cnt)
> +			min_cnt =3D cnt;
> +
> +		cpu =3D cpumask_last(cpumask_of_node(node));
> +	}
> +
> +	for_each_cpu(cpu, cpu_msk) {
> +		unsigned int node =3D cpu_to_node(cpu);
> +		const struct cpumask *msk_node =3D cpumask_of_node(node);
> +
> +		if (chn_cnt->node[node] > min_cnt)
> +			cpumask_andnot(cpu_msk, cpu_msk, msk_node);
> +
> +		cpu =3D cpumask_last(msk_node);
> +	}
> +}
> +
> +static inline void __filter_vp_index(struct vmbus_channel_counts *chn_cn=
t,
> +				     cpumask_var_t cpu_msk)
> +{
> +	filter_on_cpus(cpu_msk, chn_cnt);
> +	filter_on_nodes(cpu_msk, chn_cnt);
> +}
> +
> +static void filter_vp_index(struct hv_device *hv_dev, cpumask_var_t cpu_=
msk)
> +{
> +	/*
> +	 * The selection of the target CPUs is performed in two domains,
> +	 * the device domain and the connection domain.  At each domain,
> +	 * in turn, invalid CPUs are filtered out at two levels, the CPU

I would drop the word "invalid".  You are filtering out CPUs that meet the
criteria in the sentence starting after the colon below.

> +	 * level and the NUMA-node level: CPUs corresponding to channel
> +	 * counts *greater* than the minimum channel count for the given
> +	 * level/domain are cleared in the mask of candidate target CPUs.
> +	 */
> +
> +	__filter_vp_index(&hv_dev->chn_cnt, cpu_msk);
> +	__filter_vp_index(&vmbus_connection.chn_cnt, cpu_msk);
> +}
> +
> +static void balance_vp_index(struct vmbus_channel *chn,
> +			     struct hv_device *hv_dev, cpumask_var_t cpu_msk)
> +{
> +	u32 cur_cpu =3D chn->target_cpu, tgt_cpu =3D cur_cpu;
> +
> +	if (chn->state !=3D CHANNEL_OPENED_STATE) {
> +		/*
> +		 * The channel may never have been opened or it may be in
> +		 * a closed/closing state; if so, do not touch the target
> +		 * CPU of this channel.
> +		 */
> +		goto update_chn_cnts;
> +	}
> +
> +	/*
> +	 * The channel was open, and it will remain open until we release
> +	 * channel_mutex, cf. the use of channel_mutex and channel->state
> +	 * in vmbus_disconnect_ring() -> vmbus_close_internal().
> +	 */
> +
> +	if (!hv_is_perf_channel(chn)) {
> +		/*
> +		 * Only used by the CPU hot removal path, remark that
> +		 * the connect CPU can not go offline.

To be super explicit in the comment:  If the channel is not a
performance channel, then it does not participate in the balancing,
and we move it back to interrupting the VMBUS_CONNECT_CPU for
lack of a better choice.  Because non-perf channels are initially set to=20
interrupt the VMBUS_CONNECT_CPU, the only way a non-perf channel
could be found in this state (i.e., set to a CPU other than
VMBUS_CONNECT_CPU) is a manual change through the sysfs interface.

> +		 */
> +		tgt_cpu =3D VMBUS_CONNECT_CPU;
> +		goto modify_vp_index;
> +	}
> +
> +	/*
> +	 * Retrieve the new "candidate" target CPUs for this channel
> +	 * /device; see the inline comments in filter_vp_index() for
> +	 * a high-level description of this algorithm.
> +	 */
> +	filter_vp_index(hv_dev, cpu_msk);
> +
> +	/*
> +	 * (Try to) preserve the channel's CPU and NUMA node affinities
> +	 * respectively:
> +	 */
> +
> +	if (cpumask_test_cpu(cur_cpu, cpu_msk))
> +		goto update_chn_cnts;
> +
> +	/*
> +	 * If we reach here, a modification of the channel's target CPU
> +	 * is "needed".
> +	 */
> +
> +	tgt_cpu =3D cpumask_first_and(cpumask_of_node(cpu_to_node(cur_cpu)),
> +				    cpu_msk);
> +	if (tgt_cpu < nr_cpu_ids)
> +		goto modify_vp_index;
> +
> +	/*
> +	 * It was not possible to preserve this channel's CPU and NUMA
> +	 * node affinities; pick the "first" candidate target CPU (the
> +	 * CPU mask can not be empty).
> +	 */
> +	tgt_cpu =3D cpumask_first(cpu_msk);
> +
> +modify_vp_index:
> +	if (!vmbus_modifychannel(chn, cur_cpu, tgt_cpu))
> +		tgt_cpu =3D cur_cpu;
> +
> +update_chn_cnts:
> +	/* Do not account for non-"perf" channels in chn_cnt. */
> +	if (!hv_is_perf_channel(chn))
> +		return;
> +
> +	inc_chn_counts(&hv_dev->chn_cnt, tgt_cpu);
> +	inc_chn_counts(&vmbus_connection.chn_cnt, tgt_cpu);
> +}
> +
> +void vmbus_balance_vp_indexes_at_cpuhp(unsigned int cpu, bool add)
> +{
> +	struct vmbus_channel *chn, *sc;
> +	cpumask_var_t cpu_msk;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> +
> +	WARN_ON(!cpumask_test_cpu(cpu, cpu_online_mask));
> +
> +	/* See the header comment for vmbus_send_modifychannel(). */
> +	if (vmbus_proto_version < VERSION_WIN10_V4_1)
> +		return;
> +
> +	if (!alloc_cpumask_var(&cpu_msk, GFP_KERNEL))
> +		return;
> +
> +	reset_chn_counts(&vmbus_connection.chn_cnt);
> +
> +	list_for_each_entry(chn, &vmbus_connection.chn_list, listentry) {
> +		struct hv_device *dev =3D chn->device_obj;
> +
> +		/*
> +		 * The device may not have been allocated/assigned to
> +		 * the primary channel yet; if so, do not balance the
> +		 * channels associated to this device.  If dev !=3D NULL,
> +		 * the synchronization on channel_mutex ensures that
> +		 * the device's chn_cnt has been (properly) allocated
> +		 * *and* initialized, cf. vmbus_add_channel_work().
> +		 */
> +		if (dev =3D=3D NULL)
> +			continue;
> +
> +		/*
> +		 * By design, non-"perf" channels do not take part in
> +		 * the balancing process.
> +		 *
> +		 * The user may have assigned some non-"perf" channel
> +		 * to this CPU.  To satisfy the user's request to hot
> +		 * remove the CPU, we will re-assign such channels to
> +		 * the connect CPU; cf. balance_vp_index().
> +		 */
> +		if (!hv_is_perf_channel(chn)) {
> +			if (add)
> +				continue;
> +			/*
> +			 * Assume that the non-"perf" channel has no
> +			 * sub-channels.
> +			 */

The "if" statement below could use a bit further explanation to help
the reader. :-)  If this non-perf channel is assigned to some CPU other
than the one we are hot-removing, then we execute the "continue"
statement and leave its target CPU unchanged.  But if it is assigned
to the CPU we are hot removing, then we need to move the channel
to some other CPU.

I'm also not clear on how the above comment about having no
sub-channels is relevant.  Maybe a bit more explanation would
help.

> +			if (chn->target_cpu !=3D cpu)
> +				continue;
> +		} else {
> +			reset_chn_counts(&dev->chn_cnt);
> +		}
> +
> +		cpumask_copy(cpu_msk, cpu_online_mask);
> +		if (!add)
> +			cpumask_clear_cpu(cpu, cpu_msk);
> +		balance_vp_index(chn, dev, cpu_msk);
> +
> +		list_for_each_entry(sc, &chn->sc_list, sc_list) {
> +			cpumask_copy(cpu_msk, cpu_online_mask);
> +			if (!add)
> +				cpumask_clear_cpu(cpu, cpu_msk);
> +			balance_vp_index(sc, dev, cpu_msk);
> +		}
> +	}
> +
> +	free_cpumask_var(cpu_msk);
> +}
> +
>  /*
>   * We use this state to statically distribute the channel interrupt load=
.
>   */
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 11170d9a2e1a5..7ec562fac8e58 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -183,6 +183,18 @@ int vmbus_connect(void)
>  	spin_lock_init(&vmbus_connection.channelmsg_lock);
>=20
>  	INIT_LIST_HEAD(&vmbus_connection.chn_list);
> +
> +	vmbus_connection.channels =3D kcalloc(MAX_CHANNEL_RELIDS,
> +					    sizeof(struct vmbus_channel *),
> +					    GFP_KERNEL);
> +	if (vmbus_connection.channels =3D=3D NULL) {
> +		ret =3D -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	if (alloc_chn_counts(&vmbus_connection.chn_cnt))
> +		goto cleanup;
> +
>  	mutex_init(&vmbus_connection.channel_mutex);
>=20
>  	/*
> @@ -248,14 +260,6 @@ int vmbus_connect(void)
>  	pr_info("Vmbus version:%d.%d\n",
>  		version >> 16, version & 0xFFFF);
>=20
> -	vmbus_connection.channels =3D kcalloc(MAX_CHANNEL_RELIDS,
> -					    sizeof(struct vmbus_channel *),
> -					    GFP_KERNEL);
> -	if (vmbus_connection.channels =3D=3D NULL) {
> -		ret =3D -ENOMEM;
> -		goto cleanup;
> -	}
> -
>  	kfree(msginfo);
>  	return 0;
>=20
> @@ -295,6 +299,9 @@ void vmbus_disconnect(void)
>  	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
>  	vmbus_connection.monitor_pages[0] =3D NULL;
>  	vmbus_connection.monitor_pages[1] =3D NULL;
> +
> +	free_chn_counts(&vmbus_connection.chn_cnt);
> +	kfree(vmbus_connection.channels);
>  }
>=20
>  /*
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 188b42b07f07b..e1cade3c3c967 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -198,6 +198,20 @@ void hv_synic_enable_regs(unsigned int cpu)
>=20
>  int hv_synic_init(unsigned int cpu)
>  {
> +	/*
> +	 * The CPU has been hot added: try to re-balance the channels
> +	 * across the online CPUs (including "this" CPU), provided that
> +	 * the VMBus is connected; in part., avoid the re-balancing at
> +	 * the very first CPU initialization.
> +	 *
> +	 * See also inline comments in hv_synic_cleanup().
> +	 */
> +	if (vmbus_connection.conn_state =3D=3D CONNECTED) {
> +		mutex_lock(&vmbus_connection.channel_mutex);
> +		vmbus_balance_vp_indexes_at_cpuhp(cpu, true);

Does the target CPU have its bit in cpu_online_mask set at the time this
is executed?  reset_chn_counts() does a for_each_online_cpu() loop, and
we want to make sure the count for this CPU gets reset to zero.

> +		mutex_unlock(&vmbus_connection.channel_mutex);
> +	}
> +
>  	hv_synic_enable_regs(cpu);
>=20
>  	hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
> @@ -243,10 +257,6 @@ void hv_synic_disable_regs(unsigned int cpu)
>=20
>  int hv_synic_cleanup(unsigned int cpu)
>  {
> -	struct vmbus_channel *channel, *sc;
> -	bool channel_found =3D false;
> -	unsigned long flags;
> -
>  	/*
>  	 * Hyper-V does not provide a way to change the connect CPU once
>  	 * it is set; we must prevent the connect CPU from going offline.
> @@ -254,35 +264,37 @@ int hv_synic_cleanup(unsigned int cpu)
>  	if (cpu =3D=3D VMBUS_CONNECT_CPU)
>  		return -EBUSY;
>=20
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	/*
> +	 * The CPU is being hot removed: re-balance the channels across
> +	 * the online CPUs but excluding "this" CPU.
> +	 *
> +	 * Note.  We do not roll back on failure; IOW, we may end up with
> +	 * situations where the (re-)balancing process failed but some of
> +	 * the channels have been re-assigned to different CPUs.
> +	 *
> +	 * Also, the balancing process makes no attempt to re-assign "non-
> +	 * open" channels, that is, it only applies to channels which are
> +	 * found in CHANNEL_OPENED_STATE.
> +	 */
> +	vmbus_balance_vp_indexes_at_cpuhp(cpu, false);
> +
>  	/*
>  	 * Search for channels which are bound to the CPU we're about to
>  	 * cleanup.  In case we find one and vmbus is still connected, we
>  	 * fail; this will effectively prevent CPU offlining.
> -	 *
> -	 * TODO: Re-bind the channels to different CPUs.
>  	 */
> -	mutex_lock(&vmbus_connection.channel_mutex);
> -	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> -		if (channel->target_cpu =3D=3D cpu) {
> -			channel_found =3D true;
> -			break;
> -		}
> -		spin_lock_irqsave(&channel->lock, flags);
> -		list_for_each_entry(sc, &channel->sc_list, sc_list) {
> -			if (sc->target_cpu =3D=3D cpu) {
> -				channel_found =3D true;
> -				break;
> -			}
> -		}
> -		spin_unlock_irqrestore(&channel->lock, flags);
> -		if (channel_found)
> -			break;
> +	if (hv_is_busy_cpu(cpu) && vmbus_connection.conn_state =3D=3D CONNECTED=
) {
> +		/*
> +		 * The CPU was busy, and we are going to prevent it from
> +		 * going offline; balance the channels accordingly.
> +		 */
> +		vmbus_balance_vp_indexes_at_cpuhp(cpu, true);
> +		mutex_unlock(&vmbus_connection.channel_mutex);
> +		return -EBUSY;
>  	}
>  	mutex_unlock(&vmbus_connection.channel_mutex);
>=20
> -	if (channel_found && vmbus_connection.conn_state =3D=3D CONNECTED)
> -		return -EBUSY;
> -
>  	hv_stimer_legacy_cleanup(cpu);
>=20
>  	hv_synic_disable_regs(cpu);
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 40e2b9f91163c..b6d194caf69ed 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -18,6 +18,7 @@
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> +#include <linux/slab.h>
>=20
>  #include "hv_trace.h"
>=20
> @@ -250,6 +251,19 @@ struct vmbus_connection {
>  	/* Array of channels */
>  	struct vmbus_channel **channels;
>=20
> +	/*
> +	 * Channel counts used by the channel-interrupts balancing scheme:
> +	 *
> +	 *   - chn_cnt.cpu[cpu], the number of channel interrupts assigned
> +	 *     to CPU #cpu;
> +	 *
> +	 *   - chn_cnt.node[node], the number of channel interrupts assigned
> +	 *     to NUMA node #node.
> +	 *
> +	 * The counts refer to "open" *and "performance" channels only.
> +	 */
> +	struct vmbus_channel_counts chn_cnt;
> +
>  	/*
>  	 * An offer message is handled first on the work_queue, and then
>  	 * is further handled on handle_primary_chan_wq or
> @@ -344,6 +358,8 @@ struct vmbus_channel *relid2channel(u32 relid);
>=20
>  void vmbus_free_channels(void);
>=20
> +void vmbus_balance_vp_indexes_at_cpuhp(unsigned int cpu, bool add);
> +
>  /* Connection interface */
>=20
>  int vmbus_connect(void);
> @@ -443,6 +459,62 @@ static inline void hv_update_alloced_cpus(unsigned i=
nt old_cpu,
>  	hv_clear_alloced_cpu(old_cpu);
>  }
>=20
> +static inline bool hv_is_busy_cpu(unsigned int cpu)
> +{
> +	struct vmbus_channel *channel, *sc;
> +
> +	lockdep_assert_held(&vmbus_connection.channel_mutex);
> +	/*
> +	 * List additions/deletions as well as updates of the target CPUs are
> +	 * protected by channel_mutex.
> +	 */
> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> +		if (channel->target_cpu =3D=3D cpu)
> +			return true;
> +		list_for_each_entry(sc, &channel->sc_list, sc_list) {
> +			if (sc->target_cpu =3D=3D cpu)
> +				return true;
> +		}
> +	}
> +	return false;
> +}
> +
> +static inline int alloc_chn_counts(struct vmbus_channel_counts *chn_cnt)
> +{
> +	chn_cnt->cpu =3D kcalloc(nr_cpu_ids, sizeof(unsigned int), GFP_KERNEL);
> +	if (chn_cnt->cpu =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	chn_cnt->node =3D kcalloc(nr_node_ids, sizeof(unsigned int), GFP_KERNEL=
);
> +	if (chn_cnt->node =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static inline void inc_chn_counts(struct vmbus_channel_counts *chn_cnt,
> +				  unsigned int cpu)
> +{
> +	chn_cnt->cpu[cpu] +=3D 1;
> +	chn_cnt->node[cpu_to_node(cpu)] +=3D 1;
> +}
> +
> +static inline void reset_chn_counts(struct vmbus_channel_counts *chn_cnt=
)
> +{
> +	unsigned int i;
> +
> +	for_each_online_cpu(i)
> +		chn_cnt->cpu[i] =3D 0;
> +	for_each_online_node(i)
> +		chn_cnt->node[i] =3D 0;
> +}
> +
> +static inline void free_chn_counts(struct vmbus_channel_counts *chn_cnt)
> +{
> +	kfree(chn_cnt->cpu);
> +	kfree(chn_cnt->node);
> +}
> +
>  #ifdef CONFIG_HYPERV_TESTING
>=20
>  int hv_debug_add_dev_dir(struct hv_device *dev);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 47747755d2e1d..a40b930fb86a5 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -980,6 +980,9 @@ static void vmbus_device_release(struct device *devic=
e)
>  	mutex_lock(&vmbus_connection.channel_mutex);
>  	hv_process_channel_removal(channel);
>  	mutex_unlock(&vmbus_connection.channel_mutex);
> +
> +	if (hv_is_perf_channel(channel))
> +		free_chn_counts(&hv_dev->chn_cnt);

Again, can drop the 'if' statement.

>  	kfree(hv_dev);
>  }
>=20
> @@ -1745,38 +1748,8 @@ static ssize_t target_cpu_store(struct vmbus_chann=
el *channel,
>  	if (target_cpu =3D=3D origin_cpu)
>  		goto cpu_store_unlock;
>=20
> -	if (vmbus_send_modifychannel(channel->offermsg.child_relid,
> -				     hv_cpu_number_to_vp_number(target_cpu))) {
> +	if (!vmbus_modifychannel(channel, origin_cpu, target_cpu))
>  		ret =3D -EIO;
> -		goto cpu_store_unlock;
> -	}
> -
> -	/*
> -	 * Warning.  At this point, there is *no* guarantee that the host will
> -	 * have successfully processed the vmbus_send_modifychannel() request.
> -	 * See the header comment of vmbus_send_modifychannel() for more info.
> -	 *
> -	 * Lags in the processing of the above vmbus_send_modifychannel() can
> -	 * result in missed interrupts if the "old" target CPU is taken offline
> -	 * before Hyper-V starts sending interrupts to the "new" target CPU.
> -	 * But apart from this offlining scenario, the code tolerates such
> -	 * lags.  It will function correctly even if a channel interrupt comes
> -	 * in on a CPU that is different from the channel target_cpu value.
> -	 */
> -
> -	channel->target_cpu =3D target_cpu;
> -	channel->target_vp =3D hv_cpu_number_to_vp_number(target_cpu);
> -	channel->numa_node =3D cpu_to_node(target_cpu);
> -
> -	/* See init_vp_index(). */
> -	if (hv_is_perf_channel(channel))
> -		hv_update_alloced_cpus(origin_cpu, target_cpu);
> -
> -	/* Currently set only for storvsc channels. */
> -	if (channel->change_target_cpu_callback) {
> -		(*channel->change_target_cpu_callback)(channel,
> -				origin_cpu, target_cpu);
> -	}
>=20
>  cpu_store_unlock:
>  	mutex_unlock(&vmbus_connection.channel_mutex);
> @@ -1972,6 +1945,15 @@ struct hv_device *vmbus_device_create(const guid_t=
 *type,
>  	guid_copy(&child_device_obj->dev_instance, instance);
>  	child_device_obj->vendor_id =3D 0x1414; /* MSFT vendor ID */
>=20
> +	if (!hv_is_perf_channel(channel))
> +		return child_device_obj;
> +
> +	if (alloc_chn_counts(&child_device_obj->chn_cnt)) {
> +		free_chn_counts(&child_device_obj->chn_cnt);
> +		kfree(child_device_obj);
> +		return NULL;
> +	}
> +
>  	return child_device_obj;
>  }
>=20
> @@ -2616,7 +2598,6 @@ static void __exit vmbus_exit(void)
>  	hv_debug_rm_all_dir();
>=20
>  	vmbus_free_channels();
> -	kfree(vmbus_connection.channels);
>=20
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
>  		kmsg_dump_unregister(&hv_kmsg_dumper);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 40df3103e890b..0e9f695ea8f87 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1175,6 +1175,12 @@ struct hv_driver {
>=20
>  };
>=20
> +/* For channel-interrupts balancing. */
> +struct vmbus_channel_counts {
> +	unsigned int *cpu;
> +	unsigned int *node;
> +};
> +
>  /* Base device object */
>  struct hv_device {
>  	/* the device type id of this device */
> @@ -1191,9 +1197,21 @@ struct hv_device {
>  	struct vmbus_channel *channel;
>  	struct kset	     *channels_kset;
>=20
> +	/*
> +	 * Channel counts used by the channel-interrupts balancing scheme:
> +	 *
> +	 *   - chn_cnt.cpu[cpu], the number of channel interrupts of this
> +	 *     device assigned to CPU #cpu;
> +	 *
> +	 *   - chn_cnt.node[node], the number of channel interrupts of this
> +	 *     device assigned to NUMA node #node.
> +	 *
> +	 * The counts refer to "open" *and "performance" channels only.
> +	 */
> +	struct vmbus_channel_counts chn_cnt;
> +
>  	/* place holder to keep track of the dir for hv device in debugfs */
>  	struct dentry *debug_dir;
> -
>  };
>=20
>=20
> @@ -1523,6 +1541,8 @@ extern __u32 vmbus_proto_version;
>  int vmbus_send_tl_connect_request(const guid_t *shv_guest_servie_id,
>  				  const guid_t *shv_host_servie_id);
>  int vmbus_send_modifychannel(u32 child_relid, u32 target_vp);
> +bool vmbus_modifychannel(struct vmbus_channel *channel,
> +			 u32 origin_cpu, u32 target_cpu);
>  void vmbus_set_event(struct vmbus_channel *channel);
>=20
>  /* Get the start of the ring buffer. */
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 2371292f30b03..6853b1d3e3ce0 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -328,6 +328,7 @@ void lockdep_assert_cpus_held(void)
>=20
>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>  }
> +EXPORT_SYMBOL_GPL(lockdep_assert_cpus_held);
>=20
>  static void lockdep_acquire_cpus_lock(void)
>  {
> --
> 2.25.1

