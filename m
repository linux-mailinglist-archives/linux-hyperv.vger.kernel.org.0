Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4377919FE83
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 21:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgDFTy4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Apr 2020 15:54:56 -0400
Received: from mail-mw2nam12on2124.outbound.protection.outlook.com ([40.107.244.124]:36861
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbgDFTy4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Apr 2020 15:54:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y246/UzEp+8x8ho/8K0taEXJzp3ZX3HYz1leTvoyyxDsTHjrnpM7oRoXDZR0g9F/bumkAg3R1LnwSjD+avOJAaZKWWxLEQVouXZCapKEzVZga3QZlns+4CqMW9AgcmA43ZyYvVYMLRudM1UtMU6cYe8xxfDq27z32LdFmM+j08I0I9JmnyJ3R7jZGzPN/nuuMbn64f0q6m5yQtEKe9hkgGOZz+GcdKZaS3iMO1z6yJaL2oCSNOXyxH/LOamReDfz9VSmbyZVYVLmOg3GWLaFDLOpLRgUm+EV7d9KDHB1UGgJRZyRUQq3yTlY85OnNR4B32iqUf7omPv7jb6PcT/qkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geYO94/PK6asAmXIj/Pf/JA+/q10GabkU+nwPkhbASA=;
 b=kgdDHfcknW6isoXQfch5Ic9HCbURsXw/VlujDjtdlYbqTyYRyHVNIFxCSSsduZgLRIHAu8dH5Nv/xdw9xrjkPLuOp3yrP3dNVQj7uAi0N3hLPWHjUs/hpEnRH+TRAEUsLR/0r+QVUn5UwGsr7ph820XLo7xB2wKG6ERhNAGyQpBePjhv8DyuEpJJG9TNgzgT0LKEJZx6GYx6Ar4AduD5bnHyzG+Eb2/KUcUrP9F0HMZXdqT//exadk63z9ZfcSirl+hZEpkBN2+vOq5dRXPXc6L9Sv7RMzkd3VqGLbRZh/2d+DsOoiO8FQb6QqNqDBCwl9fayKmCDx6yhscug7MZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geYO94/PK6asAmXIj/Pf/JA+/q10GabkU+nwPkhbASA=;
 b=faml8ktXWRv9Tpgvfr0DlR1wcHQIk7TU+DEIwmPNCyD+KuXcTIhgR5yMHjhO65vX0eLRkr3BAQ8OQJdpxW55mLzzrF94j1xDD+Ehp/jRH6PrNKwOxyE2ql8pcq4yEiXS+aj8NshelmaeizNggj5pYxNWqBvGrwyp4Lc47KLexuc=
Received: from BN8PR21MB1155.namprd21.prod.outlook.com (2603:10b6:408:73::10)
 by BN8PR21MB1298.namprd21.prod.outlook.com (2603:10b6:408:a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.4; Mon, 6 Apr
 2020 19:54:47 +0000
Received: from BN8PR21MB1155.namprd21.prod.outlook.com
 ([fe80::d11:18b7:289c:ea17]) by BN8PR21MB1155.namprd21.prod.outlook.com
 ([fe80::d11:18b7:289c:ea17%6]) with mapi id 15.20.2900.012; Mon, 6 Apr 2020
 19:54:46 +0000
From:   Long Li <longli@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel
 interrupt is re-assigned
Thread-Topic: [PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel
 interrupt is re-assigned
Thread-Index: AQHWC6i+EppuRPIzmUWsHp6UWcZ3DKhscw0Q
Date:   Mon, 6 Apr 2020 19:54:46 +0000
Message-ID: <BN8PR21MB1155C78AAC02D02EA7A7841DCEC20@BN8PR21MB1155.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-12-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-12-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:edee:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ea7ba7b-72be-4ecd-2999-08d7da645ba3
x-ms-traffictypediagnostic: BN8PR21MB1298:|BN8PR21MB1298:|BN8PR21MB1298:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN8PR21MB1298DA60E660DD81C9D8FB32CEC20@BN8PR21MB1298.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1155.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(6506007)(52536014)(8676002)(81156014)(54906003)(316002)(81166006)(55016002)(7696005)(8936002)(82950400001)(82960400001)(9686003)(478600001)(10290500003)(86362001)(5660300002)(66446008)(66946007)(76116006)(33656002)(2906002)(186003)(8990500004)(110136005)(4326008)(66556008)(71200400001)(66476007)(64756008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iYdTw9uZConV56qHPwyT7PMKJBkx7mhpxeXt74udfFWItSjNfymsksTORnyOIEvqOweGIgake4CAHLtq56u+zZFl858ie2uDsEHsp0F8RGjfP6Zq93XVTLJ/H/a7F+yWUxIhdCTKBm2I2Q3OmsG/iPrqYIKxlzbQzE7BSVb2DdJj92eaQSlYu2Do8OgFwianVc59/hUeK5svsh3FvexBu0ETOnicwsWZvpvGytorJN8RLmr/53OCAPV0Rt7esTSmWg0+2frQbZdsOLuIavEpRgRsBS0XptNIdo7DgZrJIdbGVPZMZ2EeKiE/TTOScymzGUK06qFAd2d4YdWPoC3A3rLJgwJJf42MHSxeHqsY3pWg/zWDMRDObSlrFXb1UZVjoAkf2Ygp3ynJr6mCdZbFNe2n1R5ln7Gi0gjyqtt0oZgMU4mBnin7z7z6sN5xgqqk
x-ms-exchange-antispam-messagedata: vm4fmT3Qb8TH05uHx7FMtrXJ2JwiqDOgzinE7jbLqeO6OnyIB1wXicBgV3RGlzn0uWVqowDzr18nbfJ02VVRrE8JxjO/yjBD+cdvgSY7PjCgpxvuWsZKD8KqnX3R2xpyIIEzSvfXR8TrULUGwmXagL8eFt+2Kh+yWhUOxz0uJ0A6yCGpP6WMMD65lMzcxvjguGL33Mg6Z0tdqjIK7ApvLg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea7ba7b-72be-4ecd-2999-08d7da645ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 19:54:46.2040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qj37cmWdhYe2V2q1zFBhKjKzwLAF6PwcSHAN1olWP2QCDCQZeLqCl52ofeJPLVyAxV5k8NtEkmrVsDKKN/6juA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1298
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: [PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel
>interrupt is re-assigned
>
>For each storvsc_device, storvsc keeps track of the channel target CPUs
>associated to the device (alloced_cpus) and it uses this information to fi=
ll a
>"cache" (stor_chns) mapping CPU->channel according to a certain heuristic.
>Update the alloced_cpus mask and the stor_chns array when a channel of the
>storvsc device is re-assigned to a different CPU.
>
>Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
>Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
>Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
>Cc: <linux-scsi@vger.kernel.org>
>---
> drivers/hv/vmbus_drv.c     |  4 ++
> drivers/scsi/storvsc_drv.c | 95 ++++++++++++++++++++++++++++++++++---
>-
> include/linux/hyperv.h     |  3 ++
> 3 files changed, 94 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c index
>0f204640c50c2..f0be41bfcbf57 100644
>--- a/drivers/hv/vmbus_drv.c
>+++ b/drivers/hv/vmbus_drv.c
>@@ -1750,6 +1750,10 @@ static ssize_t target_cpu_store(struct
>vmbus_channel *channel,
> 	 * in on a CPU that is different from the channel target_cpu value.
> 	 */
>
>+	if (channel->change_target_cpu_callback)
>+		(*channel->change_target_cpu_callback)(channel,
>+				channel->target_cpu, target_cpu);
>+
> 	channel->target_cpu =3D target_cpu;
> 	channel->target_vp =3D hv_cpu_number_to_vp_number(target_cpu);
> 	channel->numa_node =3D cpu_to_node(target_cpu); diff --git
>a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c index
>fb41636519ee8..a680592b9d32a 100644
>--- a/drivers/scsi/storvsc_drv.c
>+++ b/drivers/scsi/storvsc_drv.c
>@@ -621,6 +621,63 @@ static inline struct storvsc_device
>*get_in_stor_device(
>
> }
>
>+void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old,
>+u32 new) {
>+	struct storvsc_device *stor_device;
>+	struct vmbus_channel *cur_chn;
>+	bool old_is_alloced =3D false;
>+	struct hv_device *device;
>+	unsigned long flags;
>+	int cpu;
>+
>+	device =3D channel->primary_channel ?
>+			channel->primary_channel->device_obj
>+				: channel->device_obj;
>+	stor_device =3D get_out_stor_device(device);
>+	if (!stor_device)
>+		return;
>+
>+	/* See storvsc_do_io() -> get_og_chn(). */
>+	spin_lock_irqsave(&device->channel->lock, flags);
>+
>+	/*
>+	 * Determines if the storvsc device has other channels assigned to
>+	 * the "old" CPU to update the alloced_cpus mask and the stor_chns
>+	 * array.
>+	 */
>+	if (device->channel !=3D channel && device->channel->target_cpu =3D=3D
>old) {
>+		cur_chn =3D device->channel;
>+		old_is_alloced =3D true;
>+		goto old_is_alloced;
>+	}
>+	list_for_each_entry(cur_chn, &device->channel->sc_list, sc_list) {
>+		if (cur_chn =3D=3D channel)
>+			continue;
>+		if (cur_chn->target_cpu =3D=3D old) {
>+			old_is_alloced =3D true;
>+			goto old_is_alloced;
>+		}
>+	}
>+
>+old_is_alloced:
>+	if (old_is_alloced)
>+		WRITE_ONCE(stor_device->stor_chns[old], cur_chn);
>+	else
>+		cpumask_clear_cpu(old, &stor_device->alloced_cpus);

If the old cpu is not allocated, is it still necessary to do a cpumask_clea=
r_cpu?

>+
>+	/* "Flush" the stor_chns array. */
>+	for_each_possible_cpu(cpu) {
>+		if (stor_device->stor_chns[cpu] && !cpumask_test_cpu(
>+					cpu, &stor_device->alloced_cpus))
>+			WRITE_ONCE(stor_device->stor_chns[cpu], NULL);
>+	}
>+
>+	WRITE_ONCE(stor_device->stor_chns[new], channel);
>+	cpumask_set_cpu(new, &stor_device->alloced_cpus);
>+
>+	spin_unlock_irqrestore(&device->channel->lock, flags); }
>+
> static void handle_sc_creation(struct vmbus_channel *new_sc)  {
> 	struct hv_device *device =3D new_sc->primary_channel->device_obj;
>@@ -648,6 +705,8 @@ static void handle_sc_creation(struct vmbus_channel
>*new_sc)
> 		return;
> 	}
>
>+	new_sc->change_target_cpu_callback =3D storvsc_change_target_cpu;
>+
> 	/* Add the sub-channel to the array of available channels. */
> 	stor_device->stor_chns[new_sc->target_cpu] =3D new_sc;
> 	cpumask_set_cpu(new_sc->target_cpu, &stor_device-
>>alloced_cpus); @@ -876,6 +935,8 @@ static int storvsc_channel_init(struct
>hv_device *device, bool is_fc)
> 	if (stor_device->stor_chns =3D=3D NULL)
> 		return -ENOMEM;
>
>+	device->channel->change_target_cpu_callback =3D
>+storvsc_change_target_cpu;
>+
> 	stor_device->stor_chns[device->channel->target_cpu] =3D device-
>>channel;
> 	cpumask_set_cpu(device->channel->target_cpu,
> 			&stor_device->alloced_cpus);
>@@ -1248,8 +1309,10 @@ static struct vmbus_channel *get_og_chn(struct
>storvsc_device *stor_device,
> 	const struct cpumask *node_mask;
> 	int num_channels, tgt_cpu;
>
>-	if (stor_device->num_sc =3D=3D 0)
>+	if (stor_device->num_sc =3D=3D 0) {
>+		stor_device->stor_chns[q_num] =3D stor_device->device-
>>channel;
> 		return stor_device->device->channel;
>+	}
>
> 	/*
> 	 * Our channel array is sparsley populated and we @@ -1258,7 +1321,6
>@@ static struct vmbus_channel *get_og_chn(struct storvsc_device
>*stor_device,
> 	 * The strategy is simple:
> 	 * I. Ensure NUMA locality
> 	 * II. Distribute evenly (best effort)
>-	 * III. Mapping is persistent.
> 	 */
>
> 	node_mask =3D cpumask_of_node(cpu_to_node(q_num));
>@@ -1268,8 +1330,10 @@ static struct vmbus_channel *get_og_chn(struct
>storvsc_device *stor_device,
> 		if (cpumask_test_cpu(tgt_cpu, node_mask))
> 			num_channels++;
> 	}
>-	if (num_channels =3D=3D 0)
>+	if (num_channels =3D=3D 0) {
>+		stor_device->stor_chns[q_num] =3D stor_device->device-
>>channel;
> 		return stor_device->device->channel;
>+	}
>
> 	hash_qnum =3D q_num;
> 	while (hash_qnum >=3D num_channels)
>@@ -1295,6 +1359,7 @@ static int storvsc_do_io(struct hv_device *device,
> 	struct storvsc_device *stor_device;
> 	struct vstor_packet *vstor_packet;
> 	struct vmbus_channel *outgoing_channel, *channel;
>+	unsigned long flags;
> 	int ret =3D 0;
> 	const struct cpumask *node_mask;
> 	int tgt_cpu;
>@@ -1308,10 +1373,11 @@ static int storvsc_do_io(struct hv_device *device,
>
> 	request->device  =3D device;
> 	/*
>-	 * Select an an appropriate channel to send the request out.
>+	 * Select an appropriate channel to send the request out.
> 	 */
>-	if (stor_device->stor_chns[q_num] !=3D NULL) {
>-		outgoing_channel =3D stor_device->stor_chns[q_num];
>+	/* See storvsc_change_target_cpu(). */
>+	outgoing_channel =3D READ_ONCE(stor_device->stor_chns[q_num]);
>+	if (outgoing_channel !=3D NULL) {
> 		if (outgoing_channel->target_cpu =3D=3D q_num) {
> 			/*
> 			 * Ideally, we want to pick a different channel if @@ -
>1324,7 +1390,10 @@ static int storvsc_do_io(struct hv_device *device,
> 					continue;
> 				if (tgt_cpu =3D=3D q_num)
> 					continue;
>-				channel =3D stor_device->stor_chns[tgt_cpu];
>+				channel =3D READ_ONCE(
>+					stor_device->stor_chns[tgt_cpu]);
>+				if (channel =3D=3D NULL)
>+					continue;
> 				if (hv_get_avail_to_write_percent(
> 							&channel->outbound)
> 						> ring_avail_percent_lowater)
>{
>@@ -1350,7 +1419,10 @@ static int storvsc_do_io(struct hv_device *device,
> 			for_each_cpu(tgt_cpu, &stor_device->alloced_cpus) {
> 				if (cpumask_test_cpu(tgt_cpu, node_mask))
> 					continue;
>-				channel =3D stor_device->stor_chns[tgt_cpu];
>+				channel =3D READ_ONCE(
>+					stor_device->stor_chns[tgt_cpu]);
>+				if (channel =3D=3D NULL)
>+					continue;
> 				if (hv_get_avail_to_write_percent(
> 							&channel->outbound)
> 						> ring_avail_percent_lowater)
>{
>@@ -1360,7 +1432,14 @@ static int storvsc_do_io(struct hv_device *device,
> 			}
> 		}
> 	} else {
>+		spin_lock_irqsave(&device->channel->lock, flags);
>+		outgoing_channel =3D stor_device->stor_chns[q_num];
>+		if (outgoing_channel !=3D NULL) {
>+			spin_unlock_irqrestore(&device->channel->lock,
>flags);

Checking outgoing_channel again seems unnecessary. Why not just call get_og=
_chn()?

>+			goto found_channel;
>+		}
> 		outgoing_channel =3D get_og_chn(stor_device, q_num);
>+		spin_unlock_irqrestore(&device->channel->lock, flags);
> 	}

With device->channel->lock, now we have one more lock on the I/O issuing pa=
th. It doesn't seem optimal as you are trying to protect the code in storvs=
c_change_target_cpu(), this doesn't need to block concurrent I/O issuers. M=
aybe moving to RCU is a better approach?

Thanks,
Long


>
> found_channel:
>diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h index
>edfcd42319ef3..9018b89614b78 100644
>--- a/include/linux/hyperv.h
>+++ b/include/linux/hyperv.h
>@@ -773,6 +773,9 @@ struct vmbus_channel {
> 	void (*onchannel_callback)(void *context);
> 	void *channel_callback_context;
>
>+	void (*change_target_cpu_callback)(struct vmbus_channel *channel,
>+			u32 old, u32 new);
>+
> 	/*
> 	 * Synchronize channel scheduling and channel removal; see the inline
> 	 * comments in vmbus_chan_sched() and vmbus_reset_channel_cb().
>--
>2.24.0

