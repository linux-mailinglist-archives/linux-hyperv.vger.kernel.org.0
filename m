Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127A92606B9
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgIGWBR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Sep 2020 18:01:17 -0400
Received: from mail-dm6nam12on2112.outbound.protection.outlook.com ([40.107.243.112]:34401
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgIGWBP (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Sep 2020 18:01:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh5cx+SWFIYFHTbycjGOnS9vomv2H38AsX4FeIAs7NggCJXGBNiIIkX3EI0xTu6Ik5srLZoW2bOMqxKcN9vnOYDv5twy4rl3qp2a7ZogW2btv1f1NrfCN0bVnKmkRu5I+u41B53mfujLP/7Tzj33gSQG3oWSHNKSmMqH7+oWLE05OJAHNbB0zrORGBKZSiQg0HGtS2H6gWa5r2WpXM8BfaaEwNgYTbAehWk+Js1nPMudQWQWikzyC9QP+2NroNpzzjamJoCSF96s26g/BwF2aMiJ8E3aLYcF2l/b6RPJjS1pHg/T03nop0CKv707i0HRKrRb2goTm76Lj6cGAQoczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yH4Eiqev/PbIOUdJJrcdScNP5YV7cpMHDuku8d1qT0=;
 b=d02ETUzTIWHueCJIs1f4hIvriPBoiEp97l6xcfcHJNOsW9iHLJsdeDP9Gi2xY/IMaKQzfTNr3bnkXc0rL1e9m74GduUI4Puye84hZ0gPNgFbgYwLQ8RbGITommEJB+rjVAZIpSxEfGSD6naTFc0CJPossHEKvCYlnKiEqIIzuUvovoeZ1Sgfgkk3J/svfCSNSc4v8+bcOBQ/5HNN2nLT2pxb0xtywBLXimqU0s/1lzroFfhWR7/yjOdBudCl4IgxHcvfykWDDMw/8aG+iDXaTHzSLqS5502QeIe5n6vg/iqx1JQ3y0Ev9LQaFzs4fVBnGZd612GtYUvAnzvycG2+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yH4Eiqev/PbIOUdJJrcdScNP5YV7cpMHDuku8d1qT0=;
 b=MBQfN5DOuooHlIJEOBWlKMSw05A/6NLy3xrKxsHbWW9qlUMWnlO2+coawRyz4qW5vymWt0g7IyspW1BB/MpzOCJYWm87uQRVPPhRIN75+X55XXwKr8MDLH/R6wduSmrcV0jp7Dc8C2Is0a0kMvvgC32Lax5wp1V81JmTtKtj4kc=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR21MB0190.namprd21.prod.outlook.com (2603:10b6:300:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.0; Mon, 7 Sep
 2020 22:01:11 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%5]) with mapi id 15.20.3370.015; Mon, 7 Sep 2020
 22:01:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: RE: [PATCH v7 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Topic: [PATCH v7 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AQHWhTK4CcuAC1huL0WTSe45bNSLyqldtpaQ
Date:   Mon, 7 Sep 2020 22:01:11 +0000
Message-ID: <MW2PR2101MB1052338B4D3B7020A2191EB7D7280@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200907161920.71460-1-parri.andrea@gmail.com>
 <20200907161920.71460-2-parri.andrea@gmail.com>
In-Reply-To: <20200907161920.71460-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-07T22:01:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b9f10162-f66b-40aa-88df-5c1411d05768;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a64c3a8a-93d3-490f-b90e-08d853798887
x-ms-traffictypediagnostic: MWHPR21MB0190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB019084846E9D1E18B5459172D7280@MWHPR21MB0190.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +9sm57Cs2kYT8096PJU8HWKsH206Xy7KERewybQBFylz2vwEyIeKot8cyQM/YAnNouuqPjUIK0V19GqGWVT+udwm3+izl2jGMxQee15RUheEYqd1WIg9xYpHnrqsp69dxoc/kcZGMw2p7qezVIFOMFwyJ4eqjpNIJy4UXxuc/YbSfcfimEG00behh4/Enhe6p64yXnlDRQm4Pf0IFP30fxDmlEwUvViLzNICI8E9rYNsmKRKu87C75qOirRewcsvXSiumeAxKTgQCeDAICeulgb1gX4FIFsd4ezGlfT/cBqFQkuc7D7InFx4soQlytnNPCLceQvtE4+uKxEN4rd125RHd5AiYOB5fUYoptHauPIdFWJx+hwY4o2/IAfeyO2Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(66476007)(5660300002)(316002)(66946007)(64756008)(66446008)(82950400001)(76116006)(8990500004)(54906003)(52536014)(82960400001)(83380400001)(478600001)(10290500003)(9686003)(8676002)(6506007)(4326008)(66556008)(7696005)(8936002)(55016002)(2906002)(86362001)(186003)(110136005)(26005)(107886003)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cDK7AsJgpDQrJUYiOK5qFD54nROuLypHVsVX+fNqcRl9ky2XYwDOTExD3T+Od5zrqoCxzgcvIIxiiv/fbFbxb2rF+ZabUOyDNpuTSuMMvGUrOFTlQArkKKc0/ptpJ0xz6/yEQKvzk8jaeYUNX8fGO5V4n52YmCAiOCRRgsQVV4aTp3GevnSGltrD2EUr9Ztys+smZLhqCnZ6Ssk8Y0/i9epo6SIDwR4VDmXLnHJ30CpuD9ss9yHLmI1K0BYmVhooVk50BQhhR/gl8mEMhF3bxyv1fQMXcRd8+WS4n6mUC8CULPtVKPwaZRNBxc3cvSwY+6IHdjhfqS4gj9cN7DsYROOKltIYT9TxDMBlipo1R9UhdJEoHGnasJsR9WzI+OgCkZY8Jz+GAkj7Q7jOD3sD3lvIf6bvz63BhwXrNHz0/WWc+0a9dfcNAhu+6eZOaA4s4SKYiU648BKuhoyVNI1Sm2O4gVH64PACT6M0Llpc/gIcIKJN0Ts6Bgy9J5UZLMzNrxiKvBHSs614ec00VAhAVah2uBWdkxfbtOCUc0kXuZlJDlWSroYgbzgTZ+eN5kD5xHkN2TMSpMVQYz3V1Wb9a1p/ks5mgPS5pUK9ndXoy8RxeBNkMFm+2/++vPOZI57PS+6OK0gqj6HIfoAxihaOzA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64c3a8a-93d3-490f-b90e-08d853798887
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 22:01:11.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dhh9udsXdNjguEydVA2iER8xqdDBiu+OOfMg6eBSARSDdEd/rxCC80o90kAaadcOWeyeokngnsVSiONppFuKqBNrx6DU0iwCknvvw0DHQag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0190
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, Septe=
mber 7, 2020 9:19 AM
>=20
> From: Andres Beltran <lkmlabelt@gmail.com>
>=20
> Currently, VMbus drivers use pointers into guest memory as request IDs
> for interactions with Hyper-V. To be more robust in the face of errors
> or malicious behavior from a compromised Hyper-V, avoid exposing
> guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
> bad request ID that is then treated as the address of a guest data
> structure with no validation. Instead, encapsulate these memory
> addresses and provide small integers as request IDs.
>=20
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> Co-developed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---

[snip]

> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -248,7 +248,8 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info=
 *ring_info)
>=20
>  /* Write to the ring buffer. */
>  int hv_ringbuffer_write(struct vmbus_channel *channel,
> -			const struct kvec *kv_list, u32 kv_count)
> +			const struct kvec *kv_list, u32 kv_count,
> +			u64 requestid)
>  {
>  	int i;
>  	u32 bytes_avail_towrite;
> @@ -258,6 +259,8 @@ int hv_ringbuffer_write(struct vmbus_channel *channel=
,
>  	u64 prev_indices;
>  	unsigned long flags;
>  	struct hv_ring_buffer_info *outring_info =3D &channel->outbound;
> +	struct vmpacket_descriptor *desc =3D kv_list[0].iov_base;
> +	u64 rqst_id =3D VMBUS_NO_RQSTOR;
>=20
>  	if (channel->rescind)
>  		return -ENODEV;
> @@ -300,6 +303,22 @@ int hv_ringbuffer_write(struct vmbus_channel *channe=
l,
>  						     kv_list[i].iov_len);
>  	}
>=20
> +	/*
> +	 * Allocate the request ID after the data has been copied into the
> +	 * ring buffer.  Once this request ID is allocated, the completion
> +	 * path could find the data and free it.
> +	 */
> +
> +	if (desc->flags =3D=3D VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
> +		rqst_id =3D vmbus_next_request_id(&channel->requestor, requestid);
> +		if (rqst_id =3D=3D VMBUS_RQST_ERROR) {
> +			pr_err("No request id available\n");
> +			return -EAGAIN;
> +		}
> +	}
> +	desc =3D hv_get_ring_buffer(outring_info) + old_write;
> +	desc->trans_id =3D (rqst_id =3D=3D VMBUS_NO_RQSTOR) ? requestid : rqst_=
id;
> +

This is a nit, but the above would be clearer to me if written like this:

	flags =3D desc->flags;
	if (flags =3D=3D VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
		rqst_id =3D vmbus_next_request_id(&channel->requestor, requestid);
		if (rqst_id =3D=3D VMBUS_RQST_ERROR) {
			pr_err("No request id available\n");
			return -EAGAIN;
		}
	} else {
		rqst_id =3D requestid;
	}
	desc =3D hv_get_ring_buffer(outring_info) + old_write;
	desc->trans_id =3D rqst_id;

The value of the flags field controls what will be used as the value for th=
e
rqst_id.  Having another test to see which value will be used as the trans_=
id
somehow feels a bit redundant.  And then rqst_id doesn't have to be initial=
ized.

>  	/* Set previous packet start */
>  	prev_indices =3D hv_get_ring_bufferindices(outring_info);
>=20
> @@ -319,8 +338,13 @@ int hv_ringbuffer_write(struct vmbus_channel *channe=
l,
>=20
>  	hv_signal_on_write(old_write, channel);
>=20
> -	if (channel->rescind)
> +	if (channel->rescind) {
> +		if (rqst_id !=3D VMBUS_NO_RQSTOR) {

Of course, with my proposed change, the above test would also have to be fo=
r
the value of the flags field, which actually makes the code a bit more cons=
istent.

Michael

> +			/* Reclaim request ID to avoid leak of IDs */
> +			vmbus_request_addr(&channel->requestor, rqst_id);
> +		}
>  		return -ENODEV;
> +	}
>=20
>  	return 0;
>  }
