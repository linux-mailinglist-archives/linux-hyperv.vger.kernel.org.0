Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924A541B9DB
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Sep 2021 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242975AbhI1WHa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Sep 2021 18:07:30 -0400
Received: from mail-oln040093003009.outbound.protection.outlook.com ([40.93.3.9]:13581
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242929AbhI1WH3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Sep 2021 18:07:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3m8R3iDnqkQrfrw/EWwT4tOpnywLuAUalvlWkndouMRzo3IG9s8C5s4RI8rWCH/2MItskQ3+sDUsysUynJVPBlj9AVDxlrTYs+/qAjCBFJBlbhqCN2JhAATnbC/cfExPKOccKuUvtmoMkW46w8zU/I9RRw24l3oqlvE1KAQo1ggLtxr/Lcvlxsx0HP4wALZKznLgzLxHaCXzRUX3Z9mBmFjqZVgBKHpG1dMiArgbc9g52qfINMfl9i+r1HcGbJvDlsco95KwOz1zRF15HqXJVwW0QOZosGYGHHS/f6vLghwABGcRWR4tvQVYgvtLMMM6LR/6yhq+CPzzW8RCUAzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Et4/L1TsKYipU6A0k17Q33kZadlLm27ZZAADyMfJLfA=;
 b=WuDJOyaMaGUzMNsunlgCyAIguh1I1kIsB+DJ/xiooFtT7oTN870Ix2MVGCkSfalTulXXyqJOjPPgLYgWXVbEx/uwfywrUXPFC4q9/QZ/EzRInlnlbRt/iXHqPDArcJvWPg0hqhAZiO9icdt0z9zRlpqmKsv+WizhOzXvRdc7tVmVgVvVxpJt93PqgnWPbXc10qBpQ9RIeYF6tOT9uj4fZkEHS4cxV7MgY73QfixCVZ1usoqBBRzAwv/aulmK8ccSdHqPqPRJFInyahP5LEzufQ0VIk2jM0TZHq8Hd2maN5EB+jZYMMeo/dmwNObJJeD2QFjoB1bhIVHb6nLqU88/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et4/L1TsKYipU6A0k17Q33kZadlLm27ZZAADyMfJLfA=;
 b=QuVkT5p5qh7lANaTdo8vH9YXf2INOXSlsW/NaK+bnRJfWfp/dkPcvQ44LwklmfLqBLLXj8/liS+WoNt9uJ876+0bzh4sSauadn00fKQ7ZlUWY7VgMmTjbXBsy8Uo7gOMmOBWdyaaBEwaeBHI+LiMlPdQ9XoJXo8X7kvFO8j70a0=
Received: from BN8PR21MB1284.namprd21.prod.outlook.com (2603:10b6:408:a2::22)
 by BN6PR21MB2091.namprd21.prod.outlook.com (2603:10b6:404:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.3; Tue, 28 Sep
 2021 22:05:42 +0000
Received: from BN8PR21MB1284.namprd21.prod.outlook.com
 ([fe80::f8ac:5395:a706:f38f]) by BN8PR21MB1284.namprd21.prod.outlook.com
 ([fe80::f8ac:5395:a706:f38f%3]) with mapi id 15.20.4566.009; Tue, 28 Sep 2021
 22:05:42 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [RFC PATCH] scsi: storvsc: Fix validation for unsolicited
 incoming packets
Thread-Topic: [RFC PATCH] scsi: storvsc: Fix validation for unsolicited
 incoming packets
Thread-Index: AQHXtIcuKpq91BhekkSiLD0Hct+0mau5/I/w
Date:   Tue, 28 Sep 2021 22:05:42 +0000
Message-ID: <BN8PR21MB128430486E2F07EA71A7FCBDCAA89@BN8PR21MB1284.namprd21.prod.outlook.com>
References: <20210928163732.5908-1-parri.andrea@gmail.com>
In-Reply-To: <20210928163732.5908-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ecfc4cb-be64-458c-937b-af3fb0c39c05;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-28T21:50:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ad008db-a460-4cfb-00b0-08d982cc1d18
x-ms-traffictypediagnostic: BN6PR21MB2091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR21MB20914CAC8A3E4C4A0C9F4C2DCAA89@BN6PR21MB2091.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihP7r7bCgf27fWYiN/zYZIReoJ7eHvdqM+JSCSK/tB3Rw4LQZPaSdD5qkJ8pXU991bHNxH1lXQpsppn+mg2JxPaTPt3IfUgAjMeeLYVaN3d8jXDn3DiM6yHmbX9DGthvuOcFOlK+X9Cn1DaeDPUA5wxBM5doBtQw4H6pFAU1fMhDZoc6kME44ukpHNn/BLBezPsGr06UVCQ3pT1qU4nEe+dtD3y5L/52qzBDdsxYF/ciXR4lwvq4S272bAsNMhUcfEhEeCPhHrfpbu3sAFPU1oK+k+4JC0kJPG/HPUnZCAv2YdT4exafbslfxwACkNS4Oapx0bg7vh7Nkty4KRcqtufUjYDscARd5DfLvdZrqdrd6UoUGb9XgaBaEIPchd7Eq5iZ4y8Lj4SFRxLRp+C8bncfHud8JQLwQFcS8yVwJTOHX+twgP7nfMphRFfEL4Z7QGxsq+RvYWbav/IWHPDYforskaQKOvY9rEs1zLr4EfYXObOeUcQJxB5Xa2TYJPwSgFy4zDZD0gqc/9eUV745tkBZFOfJwczSLGCtTSN9Wq1PjpqfMCBAuhd2zBJiL+NQVOtOhoOvIWoiKW3dIfWd2MW8Bhrr7SXvD2UGvxKZ6yonz0/W+8JI5XB1EpuZXqyxog8vyqJJydWSi0CMpGeDsF2RUQsQ1VH71XWqsgHJ3Ca/8lBbUYxgg7XqZNEj3B2ITfCISvo4CRY2d2sFDJTDig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1284.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(38100700002)(122000001)(2906002)(316002)(8676002)(66946007)(5660300002)(33656002)(53546011)(6506007)(86362001)(76116006)(54906003)(110136005)(8936002)(66446008)(64756008)(66476007)(4326008)(7696005)(66556008)(82950400001)(9686003)(186003)(508600001)(82960400001)(83380400001)(26005)(10290500003)(38070700005)(52536014)(8990500004)(55016002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3RJiP8sMSBO7MzVEsS6pl980oOVAo7R2h95XxlC+oHTqlwP+QUssoMH5VWVE?=
 =?us-ascii?Q?R03YfO4cHCQAjvkyBZ3+Y+gEeTdbT2ppe6NHWYQrVIVzCdigiArjER9m0B7k?=
 =?us-ascii?Q?/29tpNEOpTxOTD8YeDPpIkBfxymvrZbm5wr5PJeW3Pxc5QbMBx+pDQF9t6h4?=
 =?us-ascii?Q?me/wLC+2IXlJ9fGSTCJSNRMIvKN3HQ2/2KO/nOj28FNM5bsYoWRr+1V6BVjp?=
 =?us-ascii?Q?fM9rY7Jl2m7i+SWOYhN1o/8yvtxrT1EZB9YyndPjtKBW72528n4d2Y9aK4lt?=
 =?us-ascii?Q?ld1qvh/qvHeYQVrpVp008PCA5/WaznVGb8vP2Fvzw9b9MNLDoIiLkrbhLFpq?=
 =?us-ascii?Q?sqLaPEtBRraA8TCPR/wyCGKkIIBguZhFFEGtdRttuC08KLfuMmeQEAAnM5Ab?=
 =?us-ascii?Q?MpeYZ91vtueFPY8KGgM8NZQJL0j8+KnXi+ZvvFUtmMeiYn7ENUymG8fErBfA?=
 =?us-ascii?Q?fjUOXyDfYoaXRXIwurfCWd6haGVXJXFQITDv2UXlB2Cd/GHxU5tVfbT8rH0W?=
 =?us-ascii?Q?bZbFBBN7VzyUprZxJkCYlDYbRH9kwNy0+Rre6o+L27WX/UtiazluGhWfBbhg?=
 =?us-ascii?Q?+ivzJTl6W+5VbnBkyeb+C4uN5fIVuLWcVFpAguzY0i4KA3KdZ6FJviU7wYdL?=
 =?us-ascii?Q?SXSdXJ5HS0ZlYqE5z6aMYXUXk9Oac4eoVhgP7lj9g6Vbh3nu7pyN/3aXCEcj?=
 =?us-ascii?Q?X4pNzrtcLx+afRc0hxvBdNRLfVGHQ3cNr9Pfk6WIt4vvwbUaLRjnv4hOCocJ?=
 =?us-ascii?Q?947dUlA1fYsxd57KutLHbaUgT1Zdl8IB1ZCBHgdmxRvYE7eA/+lHmq5AD1aC?=
 =?us-ascii?Q?QYluFcFvkeVF+fCruV9qdMr6ijPCQlUxrvxFdeKK5wAT2mudtyEMOGFK4Vr2?=
 =?us-ascii?Q?P690S/VWTiv1X9p2qu3Ru0UiDz1i5ID1ChCEqHyYgJX6xiYZsOr6c2yclQ5m?=
 =?us-ascii?Q?5WzG+DSO11cvJezc6l5TW1PqiZWv/lKU6UBaMJTtVurnChtxFf4LLMtZFp9+?=
 =?us-ascii?Q?RxdgNpGtX+Rd5ya9Ns5mArEy5UpONDKV5ZUt90Zrp4fSBxmDGaf6lqU+Hoyv?=
 =?us-ascii?Q?6yuH3kA+VKe5f+0GAS5CWeHUqjkgt7s5PbqoUGz5yu5fJ1/4Yd6VpMaYfRjr?=
 =?us-ascii?Q?wPAKUCGVOnxf+wqA8v0iRutkLarbfJ24zBjplYUl3oNJkKw8+OHTAS7NHVOw?=
 =?us-ascii?Q?yAZWthiie4XoxQSnYD3CVTQf9SpNT6hkPpgQdEqwHHIy0PiUt5zOlpis9lp8?=
 =?us-ascii?Q?lJ340TDifzdtk1agHf0IAi59xgDINyOhsJ3RxgMA0RlUix6jn/D2VpnxwH5b?=
 =?us-ascii?Q?BPgZzTTAPkH1Wl1hpYfnjBwF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1284.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad008db-a460-4cfb-00b0-08d982cc1d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 22:05:42.0798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyptTYi57Xko8MCU4D8xy63Cb4gML22qFhaTewup32TEvVxVkYs6LA8BquV2IrFIMZBrRZIE0KDXqL+NiRvRSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB2091
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Sent: Tuesday, September 28, 2021 12:38 PM
> To: linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org; linux-
> scsi@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> Wei Liu <wei.liu@kernel.org>; James E . J . Bottomley
> <jejb@linux.ibm.com>; Martin K . Petersen <martin.petersen@oracle.com>;
> Michael Kelley <mikelley@microsoft.com>; Andrea Parri (Microsoft)
> <parri.andrea@gmail.com>; Dexuan Cui <decui@microsoft.com>
> Subject: [RFC PATCH] scsi: storvsc: Fix validation for unsolicited
> incoming packets
>=20
> The validation on the length of incoming packets performed in
> storvsc_on_channel_callback() does not apply to "unsolicited"
> packets with ID of 0 sent by Hyper-V.  Adjust the validation
> by handling such unsolicited packets separately.
>=20
> Fixes: 91b1b640b834b2 ("scsi: storvsc: Validate length of incoming
> packet in storvsc_on_channel_callback()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> The (new) bound, VSTOR_MIN_UNSOL_PKT_SIZE, was "empirically
> derived" based on testing and code auditing.  This explains
> the RFC tag...
>=20
>  drivers/scsi/storvsc_drv.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index ebbbc1299c625..a9bbcbbfb54ee 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -292,6 +292,9 @@ struct vmstorage_protocol_version {
>  #define STORAGE_CHANNEL_REMOVABLE_FLAG		0x1
>  #define STORAGE_CHANNEL_EMULATED_IDE_FLAG	0x2
>=20
> +/* Lower bound on the size of unsolicited packets with ID of 0 */
> +#define VSTOR_MIN_UNSOL_PKT_SIZE		48
> +
>  struct vstor_packet {
>  	/* Requested operation type */
>  	enum vstor_packet_operation operation;
> @@ -1285,11 +1288,13 @@ static void storvsc_on_channel_callback(void
> *context)
>  	foreach_vmbus_pkt(desc, channel) {
>  		struct vstor_packet *packet =3D hv_pkt_data(desc);
>  		struct storvsc_cmd_request *request =3D NULL;
> +		u32 pktlen =3D hv_pkt_datalen(desc);
>  		u64 rqst_id =3D desc->trans_id;
>=20
> -		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
> +		/* Unsolicited packets with ID of 0 are validated separately
> below */
> +		if (rqst_id !=3D 0 && pktlen < sizeof(struct vstor_packet) -
>  				stor_device->vmscsi_size_delta) {
> -			dev_err(&device->device, "Invalid packet len\n");
> +			dev_err(&device->device, "Invalid packet: length=3D%u\n",
> pktlen);
>  			continue;
>  		}
>=20
> @@ -1298,8 +1303,14 @@ static void storvsc_on_channel_callback(void
> *context)
>  		} else if (rqst_id =3D=3D VMBUS_RQST_RESET) {
>  			request =3D &stor_device->reset_request;
>  		} else {
> -			/* Hyper-V can send an unsolicited message with ID of 0
> */
>  			if (rqst_id =3D=3D 0) {
> +				if (pktlen < VSTOR_MIN_UNSOL_PKT_SIZE) {
> +					dev_err(&device->device,
> +						"Invalid packet with ID of 0:
> length=3D%u\n",
> +						pktlen);
> +					continue;
> +				}
> +
>  				/*
>  				 * storvsc_on_receive() looks at the vstor_packet
> in the message
>  				 * from the ring buffer.  If the operation in the
> vstor_packet is

The patch looks good. But for readability, I'd suggested put the length=20
checks together like this:

	u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) -
		stor_device->vmscsi_size_delta : VSTOR_MIN_UNSOL_PKT_SIZE;

	if (pktlen < minlen) {
		dev_err(&device->device,
			   "Invalid pkt: id=3D%llu, len=3D%u, minlen=3D%u\n",
			   rqst_id, pktlen, minlen);
		continue;
	}

Thanks.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>


