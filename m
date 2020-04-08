Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5EA91A19EE
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2020 04:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDHC0e (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Apr 2020 22:26:34 -0400
Received: from mail-eopbgr760137.outbound.protection.outlook.com ([40.107.76.137]:21735
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbgDHC0d (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Apr 2020 22:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icUloQvSsEzSUxrYhWPVn3la0/WXSD9kqxCDXDwXfvIz6DT/SumyUpuI89fGoQIkoHn2bOL+w7FXI69qSx2kO/b6akX5oOlP5E68iQF8lhCEQvwZcjNERkPM9GzBIWzDVn+Ui3YYjrONuzf0LYRoYWytsL971B4GI3dwrJHw/iyJtuj4ygDZ+doyA2lguYiTQ509xH4xlYUXZN/rKGomXBH1SPiGzq6IQxR+yQcV3JfP0L5e7bGoW3V9R5VCMxUcxrm6pcg1ZMRf2my9I7cwmSjsGRwUgcMtWoFE9ruJSNLWbMRICCTU/eYR7Ln/3AUbrR5CtGTE3grXA5ntWEnJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri7Ntj1owCwoSV82HgVjtuyx1P2vRIXNhDP52XsXnyY=;
 b=DnvmS2UzDWvXKFrC2TX1JYqVudzHf4DFB1Bq/qK3J1rVoxYMRoumVuYPR5dNjt/iELwQrYfpA7jjbTXB+Q9JmIuMJyRRgDJBVWCDzu3XDdjBnp8UgtE7HNx7upqwEJmXljrBCJ721l6GQJ9Vk0l50YnRe/OIfthiUBBOwk28FapAKGmp9Sin/IervzLLdlsXIFiXWyjdNzgtyW5o+eTeirX/UK22EJ2Oor7w+oylbjJaghZkf5xWCYvaISUqAPofFLMkbKOxCvadlmbV+O66lxLF/ZToFeaSsTUZ/LZJNlyB5ZyWTpmLPUixRwRI5pJdaAcaVTCdq5pDOAxRZ57OTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri7Ntj1owCwoSV82HgVjtuyx1P2vRIXNhDP52XsXnyY=;
 b=Rl96MyryChdLYf6EfCYEUaAjG+WUi6TToALTG+WxbKso1zMNLGACB4/aiF8BrpcFX1OmThNUerlbGsTdpp28SIjP2pobstEo6uLHvkioSIhSIrFEscm2l3Y35u6/j2FUud+FjnXDUuqNRsSjMXdAfHMN5ySHeqVHIhW3Zz/U/5E=
Received: from BN8PR21MB1155.namprd21.prod.outlook.com (2603:10b6:408:73::10)
 by BN8PR21MB1364.namprd21.prod.outlook.com (2603:10b6:408:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.10; Wed, 8 Apr
 2020 02:25:52 +0000
Received: from BN8PR21MB1155.namprd21.prod.outlook.com
 ([fe80::d11:18b7:289c:ea17]) by BN8PR21MB1155.namprd21.prod.outlook.com
 ([fe80::d11:18b7:289c:ea17%6]) with mapi id 15.20.2900.012; Wed, 8 Apr 2020
 02:25:52 +0000
From:   Long Li <longli@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
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
Thread-Index: AQHWC6i+EppuRPIzmUWsHp6UWcZ3DKhscw0QgABenQCAAa+rcA==
Date:   Wed, 8 Apr 2020 02:25:52 +0000
Message-ID: <BN8PR21MB1155E335C1E390964C08B6E3CEC00@BN8PR21MB1155.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-12-parri.andrea@gmail.com>
 <BN8PR21MB1155C78AAC02D02EA7A7841DCEC20@BN8PR21MB1155.namprd21.prod.outlook.com>
 <20200407003459.GA7776@andrea>
In-Reply-To: <20200407003459.GA7776@andrea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:0:edee:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cba394b-ff6e-44cd-050f-08d7db642913
x-ms-traffictypediagnostic: BN8PR21MB1364:|BN8PR21MB1364:|BN8PR21MB1364:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BN8PR21MB136441DB07D1EC45C77A4C53CEC00@BN8PR21MB1364.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1155.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(55016002)(6506007)(54906003)(86362001)(9686003)(66556008)(76116006)(66946007)(66476007)(5660300002)(66446008)(64756008)(10290500003)(478600001)(2906002)(71200400001)(52536014)(7696005)(8936002)(8676002)(82950400001)(81156014)(81166006)(82960400001)(8990500004)(186003)(6916009)(4326008)(33656002)(316002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: huwdLpsSkcFz0gEzuj6COlsvI0z29Sja+WbkdJxDveTGT5kK/tS4d8O2PULxnlN9bLQJOsbxWy+qdWQEwbhp56ExbhgnwOS1GFOBLRBgIM0Qt+bTp60YexrsUjVtL49MKgvkY9g03KFlVrCM3E2JTn+9Dfw7qRaC1XYXGnhozJImNoC3qMTaakUwmYC2oHg0xr58viwxAMa4nyhBv6dp3KoiF5HAUmI7E0/WqvzX4XeecNQ2x+riZfZr/3MjvrczAW6NWQBnEvmx510RKXOZ7+5OFsEoayNBKi7/jcpnGDcn0RyqNkh5LfGoWMnoyhd2zQB00JcZkkIP/Akm5zFFFmlNUZZegNYvdJOCkBTSNpAx2FqalttZTGor84Nog7F0h+GnMoPrX3Mo3BnzcIk/vJ9dW7HG/xecvxK76XF/XHIJNJs8uQTgBp7Uke1L5m4n
x-ms-exchange-antispam-messagedata: clw/CvRicyX2TGLzqpDdJdmnq8It/TyAZu4JtVTHD/97HLOkWgU45g1r6dlhTCvZzUzi+upqkfoaMfm+L3vsxMQ3Y4ejNWWQTc6NZgpC7TvI/xHV73mk73n5QnT6ouP0zU+Q6tkVpwBbWI0YV7KukcRM0WYCFzmNihxPwq3alV+zzhW2R/Wz+8hcrF4j7bVYXnqBFBLT92x1rsqDhOliUw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cba394b-ff6e-44cd-050f-08d7db642913
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 02:25:52.6910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxDfTEha5DaXXn6ql+xNfSVPjsk9Qa2529krq+2lZPCdWDrI2zWBRdAbSARUT0mwatoxP0XQyxYh5Q0acnDCEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1364
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: Re: [PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel
>interrupt is re-assigned
>
>> >@@ -621,6 +621,63 @@ static inline struct storvsc_device
>> >*get_in_stor_device(
>> >
>> > }
>> >
>> >+void storvsc_change_target_cpu(struct vmbus_channel *channel, u32
>> >+old,
>> >+u32 new) {
>> >+	struct storvsc_device *stor_device;
>> >+	struct vmbus_channel *cur_chn;
>> >+	bool old_is_alloced =3D false;
>> >+	struct hv_device *device;
>> >+	unsigned long flags;
>> >+	int cpu;
>> >+
>> >+	device =3D channel->primary_channel ?
>> >+			channel->primary_channel->device_obj
>> >+				: channel->device_obj;
>> >+	stor_device =3D get_out_stor_device(device);
>> >+	if (!stor_device)
>> >+		return;
>> >+
>> >+	/* See storvsc_do_io() -> get_og_chn(). */
>> >+	spin_lock_irqsave(&device->channel->lock, flags);
>> >+
>> >+	/*
>> >+	 * Determines if the storvsc device has other channels assigned to
>> >+	 * the "old" CPU to update the alloced_cpus mask and the stor_chns
>> >+	 * array.
>> >+	 */
>> >+	if (device->channel !=3D channel && device->channel->target_cpu =3D=
=3D
>> >old) {
>> >+		cur_chn =3D device->channel;
>> >+		old_is_alloced =3D true;
>> >+		goto old_is_alloced;
>> >+	}
>> >+	list_for_each_entry(cur_chn, &device->channel->sc_list, sc_list) {
>> >+		if (cur_chn =3D=3D channel)
>> >+			continue;
>> >+		if (cur_chn->target_cpu =3D=3D old) {
>> >+			old_is_alloced =3D true;
>> >+			goto old_is_alloced;
>> >+		}
>> >+	}
>> >+
>> >+old_is_alloced:
>> >+	if (old_is_alloced)
>> >+		WRITE_ONCE(stor_device->stor_chns[old], cur_chn);
>> >+	else
>> >+		cpumask_clear_cpu(old, &stor_device->alloced_cpus);
>>
>> If the old cpu is not allocated, is it still necessary to do a cpumask_c=
lear_cpu?
>
>AFAICT, this really depends on how much we "believe" in the current heuris=
tic
>(as implemented by get_og_chn()):  ;-)
>
>The cpumask_clear_cpu() (and the below, dependent "flush" as well) are
>intended to re-initialize alloced_cpus and stor_chns in order for get_og_c=
hn()
>to re-process/update them.
>
>Also, notice that (both in the current code and after this series) alloced=
_cpus
>can't be offlined and get_og_chn() does rely on this property (cf., e.g., =
the
>loop/check over alloced_cpus/node_mask).
>
>I suspect that giving up on this invariant/property would require a certai=
n
>amount of re-design in the heuristic/code in question...
>
>
>> >@@ -1360,7 +1432,14 @@ static int storvsc_do_io(struct hv_device
>*device,
>> > 			}
>> > 		}
>> > 	} else {
>> >+		spin_lock_irqsave(&device->channel->lock, flags);
>> >+		outgoing_channel =3D stor_device->stor_chns[q_num];
>> >+		if (outgoing_channel !=3D NULL) {
>> >+			spin_unlock_irqrestore(&device->channel->lock,
>> >flags);
>>
>> Checking outgoing_channel again seems unnecessary. Why not just call
>get_og_chn()?
>
>target_cpu_store() might have changed stor_chns (and alloced_cpus) in the
>meantime (but before we've acquired the device's lock): the double check i=
s
>to make sure we have a "consistent"/an up-to-date view of stor_chns and
>alloced_cpus.
>
>
>>
>> >+			goto found_channel;
>> >+		}
>> > 		outgoing_channel =3D get_og_chn(stor_device, q_num);
>> >+		spin_unlock_irqrestore(&device->channel->lock, flags);
>> > 	}
>>
>> With device->channel->lock, now we have one more lock on the I/O issuing
>path. It doesn't seem optimal as you are trying to protect the code in
>storvsc_change_target_cpu(), this doesn't need to block concurrent I/O
>issuers. Maybe moving to RCU is a better approach?
>
>I don't see this as a problem (*and I've validated such conclusion in
>experiments, where the "patched kernel" was sometimes performing slighlty
>better than the "unpatched kernel" and sometimes slightly
>worse...):
>
>On the one hand, the stor_chns array "stabilizes" quite early after system
>initialization in "normal" (i.e., common) situations (i.e., no channel
>reassignments, no device hotplugs...); IOW, get_og_chn() really represents
>the "rare and slow" path here (but not that slow!
>after all...).  Furthermore, notice that even in those "rare cases"
>the number of "contending" channels is limited to at most 1 per 4 CPUs IIR=
C
>(alloced_cpus is "sparsely populated"...).

Yes I realized it is on the slow path. There is no need to optimize locks.

Reviewed-by; Long Li <longli@microsoft.com>

>
>The latencies of the RCU grace period (in the order of milliseconds) would=
 be a
>major concern for the adoption of RCU here (at least, if we continue to
>consider get_og_chn() as an "updater").  I'm afraid that this could be "to=
o
>slow" even for our slow path...  ;-/
>
>What am I missing?  ;-)
>
>Thanks,
>  Andrea
