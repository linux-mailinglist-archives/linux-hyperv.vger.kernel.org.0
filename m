Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FBA35FAE6
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Apr 2021 20:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhDNSnp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Apr 2021 14:43:45 -0400
Received: from mail-eopbgr760127.outbound.protection.outlook.com ([40.107.76.127]:30854
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231288AbhDNSnn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Apr 2021 14:43:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5lkPR3n4RwPUCp6yCiq325PSQhwDTRC2gUkmjeU0iFduTtr5rNeRfMOAh8N3DuYHJAAXK4ZLPhI9IqF/K4xARSfWm7kV+O8XGt7AfOvRQd+h+Glc+us7EJtFAu84syvL2+Nz4DlxgybRENbzHCi723ijr7WHr5MKeENwfUFeWk8pAU+2ORgNcsljh3TBZBI/mVUec8zsFjn4KL0IJlWk6ZnA4NVLV+ZNQtp64G2qKvjXFSzJ4fyIyp4a2fuXFhQBk4Mys5Ul0HjK/63g2LIxiyHfJXNo7x90DvBolm8mVKA6jEzNT6QJL4WAyYssE5qAS0Sg8nWIJyYar95SlFQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq2ul2zYbhxKYlC19aZ9PAjUgqo3uirfY6P/PELRVo4=;
 b=Dpy+yVsrQVrd1WLM5+nA9lChAPfKCCJF0GilQr/uHCE+j/J1MG+CR+V2+K/05/z5CCwmmOQiFl+NyL1jX7MTUtvafNOqb4AT82OanGUEpnmC6oXlxA0lOelCO/d0bVDLIQCP09C5IOz0u7CKOSNVZwwD+ldN3hVmnN6ew2XaIkQMGMSHskZe3aY4F3g9yPUPluGyXCS4B6N1hEhh3nc+yXZoN/Y+GovseRvsiKQY87iB3qEkgRk4tzhQDcheh+ATbwvhgA/lQQZHqDeWnZ6NxWud23ZRG62xjED6i9trLV8Ndmv4WbIamrbJpNHHX9fh27izzFWkdAZHBa72DTg/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq2ul2zYbhxKYlC19aZ9PAjUgqo3uirfY6P/PELRVo4=;
 b=DDuFV67p9+/lYBMRZ7I3ZhSMWS8UrRz5MVekb7k1U8Ur9MOjn7kIZKxZ7Kmq6uEKBF9d60lrRn4Ew0Ng9eOBc9KlSmEpcOBSHRsWX777FVertwdU5zrslvpghx3NgJd9Ey+69LQfvLyQ6eHIx86HznIpqvRjp45ealiKbTuMXL8=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0766.namprd21.prod.outlook.com (2603:10b6:300:76::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.2; Wed, 14 Apr
 2021 18:43:19 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c30:6e04:401d:c31f%4]) with mapi id 15.20.4042.017; Wed, 14 Apr 2021
 18:43:19 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] Drivers: hv: vmbus: Check for pending channel
 interrupts before taking a CPU offline
Thread-Topic: [PATCH v2 3/3] Drivers: hv: vmbus: Check for pending channel
 interrupts before taking a CPU offline
Thread-Index: AQHXMT8SvHT8x+MMrkOGlI7J8353+aq0VPuQ
Date:   Wed, 14 Apr 2021 18:43:19 +0000
Message-ID: <MWHPR21MB15931F523196BCE9E23293E4D74E9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210414150118.2843-1-parri.andrea@gmail.com>
 <20210414150118.2843-4-parri.andrea@gmail.com>
In-Reply-To: <20210414150118.2843-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85ffc388-eac9-48e9-9b99-770daac6b918;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-14T18:26:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 060f1160-700b-46f7-ae2b-08d8ff752c55
x-ms-traffictypediagnostic: MWHPR21MB0766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB076663E0BFF5FA6024C0CEF6D74E9@MWHPR21MB0766.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bbyMz28N1OwWfieYmYItfBh0oJIKYBipr/fB8TaosYDEENvI7hSPaAftVxPD9dAtnelG42sb0HQAaB67PnRP2LCA/NkhB/y6CU4c+QnWtFUqqbHuT5nKld2gyrT3cO2SBMxRz09TXxc/FHi/FhLHUOX+UCr4zOLkb12jatJDRzTPIuDR0HKyleSeI+6W7cB5ImQU80Llb96Z3zFDY33DNpHopD+kThW4y3B1a1v2cY+JyRieEIUlDz00N5jTjdLReLR3Qvck+zps2umFOi413SRC5SHBlALZTUlDn+xZZ1hnYk2jorFa7K5/ieEkOSRLDEijgL9g1De67d9l96YPIchmMC/NlUBw6W0iZtqLKJ47UcEGJuD9bqf7brcSkKJDojKjcwZPn4tz+IbP1tEFrL7j2dkQtUp0UUcHHDChLK58T5UyXqnSywibegJqZRmIBDhGD58O1GbNs5Cm3fUTq0j/dxRygRT3vYxsxhSimHcxze6cQETK59o4SUR6lZjq2h8o4sP4YV8bL0nC/Fno8aZRb29MR7zlb3BEGFHVGZYmD/nPJflmw2f+80U7q5Ksf/a49jiHMgRvpFo3Q3aIBaMlnnSI7ZFafcpnqAr38UY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(5660300002)(122000001)(478600001)(8936002)(76116006)(2906002)(33656002)(26005)(38100700002)(52536014)(186003)(10290500003)(8676002)(316002)(110136005)(83380400001)(7696005)(71200400001)(66556008)(66476007)(6506007)(82960400001)(82950400001)(64756008)(66446008)(66946007)(55016002)(9686003)(4326008)(86362001)(54906003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lVElmx0bxXnAPHdxZtrlO2VJilIWJ3vTdwBTRSzaWfLbRrsrJZZcWQ13cHs3?=
 =?us-ascii?Q?/4tEUyuKKkfnA7k901lSQIzOTybcv9why/hIwzAj8EvmJetgQN9kViIZzWyb?=
 =?us-ascii?Q?yl+ctNW4XsCaAhJxEyIjBR0lkEwXAKMgDXgd/0v47Pr9+0F/3A9g8mYhyf1e?=
 =?us-ascii?Q?piKv31wPPdZki5PAGXecOCvtHmjEUHi3i7u94Iq8jXeT0M34rKZGV7b9U00h?=
 =?us-ascii?Q?vKIAa5NX97Q7StW1QIFD2PgYcXi+nEDavVoBTNViLvSh1YPRDnx/mXKNdL74?=
 =?us-ascii?Q?cBMLXx6/9PirEbvmKE7v/5JLiXEnay4Qs2KYYkPJG2AukMd0abj1mOOXO/9A?=
 =?us-ascii?Q?Z0luMFFMLOhoyVbgHpjA4nhIMPth6dAOJ9G+/HqZOgiOxZSeUV+GNJCPZkP1?=
 =?us-ascii?Q?ZjYIaOmLTrlp7RdBNF9RD2CQAY42lHDOjQmnmGBU2JTwOSzpzqpDC1jufm5B?=
 =?us-ascii?Q?3cx8zWnOnu38mS7K2x7hhnfGgCOnuqSsLL/uo9S7AzMpU1kzdsEeynCzoelE?=
 =?us-ascii?Q?N4Bhy6qOvRAaM8cLAUpHAWIt0f7NNzXN5NE3MkB6LD2fVlyPMFDvcdMAqBKr?=
 =?us-ascii?Q?YvTNlQlRrhkOIvYAiMWXxKe+ZKQvcLeLjHHQyO9Hcy5uJBrswnDX+gMC7l3t?=
 =?us-ascii?Q?Btp+2IhvXYsSJKAivv8RqekjmwYhL0HFgKaDNJFm6j6OXw/rHkaYExq2ye0F?=
 =?us-ascii?Q?F5YxUB0rUZD72qply9Vrc8MaoW5sNymVFEboNlQQQybn87T+jk45wqhZ5/mU?=
 =?us-ascii?Q?Oyfx3ztSPUUdNakaVrLdKJOsCU9h2rLRa9wSuyPNq4ftGx0EyD63G9KfC1kH?=
 =?us-ascii?Q?ZxSi7vWeGyJRybqvlj7s/NFIi5obvFYe3kwPvIyBAr8N8y1iYYeXCIK+8XdW?=
 =?us-ascii?Q?B+zs2g1fRFRYgNkc3H5/B3G91iguUV3dkxn+uaVS8ce3RFMMELXAsk917wCe?=
 =?us-ascii?Q?96upDJ92sWVprqj+r71kieDqJ+wlXIdJAh0RT7oIybka5Nw+2jLeUIucEi7e?=
 =?us-ascii?Q?2FNqV+D5j7CCPtxe3R0/HNWTEhfmWyieZmoaYfvmq0EATdUqXnbyYUQ/0vjs?=
 =?us-ascii?Q?qGkcRHp3CzZM7d7FZqCznPJB9AT7O+RdxybpvDDYkDUgeyfC2J1NrCyUHMhB?=
 =?us-ascii?Q?pGfbT0Zdt7xwxTjmlzS+N9X2hu8aLWTb/BdKhAolrtoWObK8v14p5dP/QTFY?=
 =?us-ascii?Q?02NbcYa+w/onkGlq9L2sxHpa+qV915L4+0OWXiXeyF1Yhbj7x+4gbaTN+emD?=
 =?us-ascii?Q?sPhcerqKHrYxV8NYKmKTR4KBYR10YvGwj+PRH3T4iO/iqP0Cg0yM7MM+LKC/?=
 =?us-ascii?Q?EBw73tzx0QtmDEg8o8clBlqk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060f1160-700b-46f7-ae2b-08d8ff752c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 18:43:19.1944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBx0rSEEdgJRGV8rIMuX1WseIQOezS4yYh+gBHkb1TgvrZ7Q7tPtk3IqxnvYbYYE8ainsD7fZ0Eb4O5TBFz8a/mmfk8sm8GAP79CsLS7hF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0766
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ap=
ril 14, 2021 8:01 AM
>=20
> Check that enough time has passed such that the modify channel message
> has been processed before taking a CPU offline.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/hv.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 3e6ff83adff42..dc9aa1130b22f 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -15,6 +15,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/random.h>
>  #include <linux/clockchips.h>
> +#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
> @@ -292,6 +293,41 @@ void hv_synic_disable_regs(unsigned int cpu)
>  		disable_percpu_irq(vmbus_irq);
>  }
>=20
> +#define HV_MAX_TRIES 3
> +/*
> + * Scan the event flags page of 'this' CPU looking for any bit that is s=
et.  If we find one
> + * bit set, then wait for a few milliseconds.  Repeat these steps for a =
maximum of 3 times.
> + * Return 'true', if there is still any set bit after this operation; 'f=
alse', otherwise.
> + *
> + * If a bit is set, that means there is a pending channel interrupt.  Th=
e expectation is
> + * that the normal interrupt handling mechanism will find and process th=
e channel
> interrupt
> + * "very soon", and in the process clear the bit.
> + */
> +static bool hv_synic_event_pending(void)
> +{
> +	struct hv_per_cpu_context *hv_cpu =3D this_cpu_ptr(hv_context.cpu_conte=
xt);
> +	union hv_synic_event_flags *event =3D
> +		(union hv_synic_event_flags *)hv_cpu->synic_event_page +
> VMBUS_MESSAGE_SINT;
> +	unsigned long *recv_int_page =3D event->flags; /* assumes VMBus version=
 >=3D
> VERSION_WIN8 */
> +	bool pending;
> +	u32 relid;
> +	int tries =3D 0;
> +
> +retry:
> +	pending =3D false;
> +	for_each_set_bit(relid, recv_int_page, HV_EVENT_FLAGS_COUNT) {
> +		/* Special case - VMBus channel protocol messages */
> +		if (relid =3D=3D 0)
> +			continue;
> +		pending =3D true;
> +		break;
> +	}
> +	if (pending && tries++ < HV_MAX_TRIES) {
> +		usleep_range(10000, 20000);
> +		goto retry;
> +	}
> +	return pending;
> +}
>=20
>  int hv_synic_cleanup(unsigned int cpu)
>  {
> @@ -336,6 +372,19 @@ int hv_synic_cleanup(unsigned int cpu)
>  	if (channel_found && vmbus_connection.conn_state =3D=3D CONNECTED)
>  		return -EBUSY;
>=20
> +	if (vmbus_proto_version >=3D VERSION_WIN10_V4_1) {
> +		/*
> +		 * channel_found =3D=3D false means that any channels that were previo=
usly
> +		 * assigned to the CPU have been reassigned elsewhere with a call of
> +		 * vmbus_send_modifychannel().  Scan the event flags page looking for
> +		 * bits that are set and waiting with a timeout for vmbus_chan_sched()
> +		 * to process such bits.  If bits are still set after this operation
> +		 * and VMBus is connected, fail the CPU offlining operation.
> +		 */
> +		if (hv_synic_event_pending() && vmbus_connection.conn_state =3D=3D CON=
NECTED)
> +			return -EBUSY;
> +	}
> +

Perhaps the test for conn_state =3D=3D CONNECTED could be factored out as f=
ollows.  If we're
not CONNECTED (i.e., in the panic or kexec path) we should be able to also =
skip the search
for channels that are bound to the CPU since we will ignore the result anyw=
ay.

	if (vmbus_connection.conn_state !=3D CONNECTED)
		goto always_cleanup;

	if (cpu =3D=3D VMBUS_CONNECT_CPU)
		return -EBUSY;

	[Code to search for channels that are bound to the CPU we're about to clea=
n up]
=09
	if (channel_found)
		return -EBUSY;

	/*
	 * channel_found =3D=3D false means that any channels that were previously
	 * assigned to the CPU have been reassigned elsewhere with a call of
	 * vmbus_send_modifychannel().  Scan the event flags page looking for
	 * bits that are set and waiting with a timeout for vmbus_chan_sched()
	 * to process such bits.  If bits are still set after this operation
	 * and VMBus is connected, fail the CPU offlining operation.
	 */
	if (vmbus_proto_version >=3D VERSION_WIN10_V4_1 && hv_synic_event_pending(=
))
		return -EBUSY;

always_cleanup:

>  	hv_stimer_legacy_cleanup(cpu);
>=20
>  	hv_synic_disable_regs(cpu);
> --
> 2.25.1

