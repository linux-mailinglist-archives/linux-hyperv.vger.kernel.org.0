Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE84240E7
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 17:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbhJFPLv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 11:11:51 -0400
Received: from mail-bn8nam11on2138.outbound.protection.outlook.com ([40.107.236.138]:1056
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238124AbhJFPLv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 11:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIAUtOkO0OLidHMz3QWX1qV1LYW8Pqvfkn0mPD3rZG4TMBZGtEa85hxwAku2uzja0v3E3Q63A/e010GlmVTX2YJWIoEjyv1wfalM328C29XzXjBAh4c+8rSz+8sSAUKyIcgwmh9mZdf7HrqqmZZtarXg/qdmWuwxl1SXrA1pj3lY7S9w5iZd1vUQQrYHwsfNZS4BUOO2JXHCLsY/kb97qfJmWaTtegqJ/7s5fEoRI/pZjRkRGVyM7+yGResaVTtWt0KhE/u0G0vfpsr3757Pwf388PRfi8Fehinc/RTFkl16TH34RhOSsK6UZ+c9w23HqTDd1UZbMKity2KBgedPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA8VwG4UiebifVSDT9Hfh9Dv8kA1R5eQngtJflyhO2o=;
 b=c6+9QeHp/jApvmMOrqk55OUoQIfopPaPMNwvJ0J2ZKgRU/SSktQjXF5d8uhpHEm5BaH2BLw0r47RtHzCFSFe8AaDid6Cr5rgL+A2LGXbxMNfGwP7Vc2LSV3IB6L2+ElZ+vwzhXRjOQFzKameKDoYqSlL2HwBq9tiabuAqy81COYNF/Ks7F0IkZF4ThaG5iHazaPvfTiFdLjHgCF4XpyRxf2a6tOswD8eGR24jJDt4Ih2GzqzCu71+0Hn6UMm2VL5QHlPjDo+Lj6L+WrHb9Xw6H26LTX/tMA4lLe2IlAtrqSZqYgr3k5gxaDwsFZbmBcwJqDujZ/pr6GZ/qIKTQJt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA8VwG4UiebifVSDT9Hfh9Dv8kA1R5eQngtJflyhO2o=;
 b=I1rCNmr91fCYN7jFaz6GDV6g6qErHf2fDnmg73fTgqs5HF3IW48qfPVIETDawRa+S3MfikpcSW82oOHeBFGlsNJGxln48iHRVdYoWQ3ix+OyPvzLltweWh7WzbEXgsdxR9hzmJLmhKBMlA4e54uqdhbWTuwECcuEyigqRrVxYvE=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0479.namprd21.prod.outlook.com (2603:10b6:300:ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.3; Wed, 6 Oct
 2021 15:09:54 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::6129:c6f7:3f56:c899%4]) with mapi id 15.20.4587.017; Wed, 6 Oct 2021
 15:09:54 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2] scsi: storvsc: Fix validation for unsolicited incoming
 packets
Thread-Topic: [PATCH v2] scsi: storvsc: Fix validation for unsolicited
 incoming packets
Thread-Index: AQHXurT5XluLbidvpUmp7+iI0FyWYqvGEj0Q
Date:   Wed, 6 Oct 2021 15:09:54 +0000
Message-ID: <MWHPR21MB1593050119EACC0E49748209D7B09@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211006132026.4089-1-parri.andrea@gmail.com>
In-Reply-To: <20211006132026.4089-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=36d16c26-41c7-452d-8173-316745f91995;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-06T15:07:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f054ccad-7894-4d70-d046-08d988db5a90
x-ms-traffictypediagnostic: MWHPR21MB0479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0479056F85EBE8BA00AB40AFD7B09@MWHPR21MB0479.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHQQh7Gx25z119x/LSycof48MiiCARG4qcqOufiKteEzlFIt932bD61R8czZy6z9jtYC1mnZq14WDun+srSmyPVP+bfHEWbDUvIIO+fXnrlaAK4yeZ0P9ncq2Ivy9ZZmjwhMqCuwQcydveVnXH6LUEeYAFvHEKvBnF1eq8xclBypj+NjO2DAH/EPrg9gM32sooYiTr3FDvz8lq8uZ1XpJaZugQSmv1GkOXJmhhCcuSWdHM7oI1LpafipG03QDwCO5srsSucsZlwh7l/KPeklRIQCgmIAop2yN3f6rTPrSF5jYLMfQVvx6Ug/uxVNwwqoV47ybO5MV58TYvDE8ZDJC3TdUf0PKSserXFIUncNfxhNBLL3wBJS9IedDZRllNkKVjaUVcndUCg4jCsdN5B1pfry25ES58NY2Ad0vQ7LrFD+AHfFjaiYqtjHgP2tyZEVadq8VHl90o+58dVsUzaq26Ens8cGlFcx4AXqyfNLr7uEDnghaDZGFkMfpXzhmX99Tu5tVfcgHpbaqCeUmrrplbzskBMxblepWf8vEgWjxHXESp+RPWLNx16wLZBwqpO6mzslXiVlVNYvl6m3oZeFD00aw0ZlZZHCd7Lu88m5+aRB4ZAsOXIDP2Ef86eEda6TDba6a4Pkg/FQfaTXtU9zGZ1C1XK3NvkatAyEcJMQVu7gdJOuuRk8/dASzGho0SgajwSz/Nw0j4dGdLmR7OYrPMZ/SfillHHG/v/wQbmJTeNTAernPkklN8G7IInpqh7+o5TwegrixaijERHYtyPfIbQdvTj80koxm1M6MZFt2Gl/+fsbsleCeun9e3QAwJJC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(10290500003)(38100700002)(76116006)(66556008)(66446008)(66946007)(508600001)(26005)(6506007)(52536014)(66476007)(8676002)(8936002)(64756008)(7696005)(966005)(82960400001)(82950400001)(316002)(38070700005)(110136005)(83380400001)(2906002)(186003)(54906003)(86362001)(71200400001)(8990500004)(4326008)(55016002)(9686003)(5660300002)(33656002)(107886003)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DJoJtzcRdQNUgyZyvgUwVzxvDQmyvGJes92PYPpBc7CusYY/gyWHFJqUYTe9?=
 =?us-ascii?Q?2TB4G8PymM9tneKHzQr+3HZVfxXPVbN2h6LaFurs2ZX3iVhIDIWzCrRpfMk4?=
 =?us-ascii?Q?SNWUVNHHf0/7/0uK7/PvZoFTXoAcV5TYWlHofvk7blWe4jbioyyZeIBjV5zU?=
 =?us-ascii?Q?Laf6Hupc7bUpTyVTSXpyIyE3GYfxq3T22RRG+C7+AIutOd7v9rWuRvIPKaGM?=
 =?us-ascii?Q?yEyipvEhBNORVsJL03qCINT3mXJ5cyZB+FtEft/cQ5YktPqHO+5oTS1dihmg?=
 =?us-ascii?Q?hAj9gAgEgokg/lWDfZmCSd/AS8goEkU2ELbf8Yu99BbTkXCp3wjRZok4yqyk?=
 =?us-ascii?Q?8/7q9hYXfWSls6LlRBM6Vzci5j94K4VP8gQG97ZGfRycXGZ6uCx3yN5zuBkG?=
 =?us-ascii?Q?LDsi6UiMSJsHvQN13+B85qNPxpvKqk4UUHukU5yBbFILhr1lt1OOwGD2rKLy?=
 =?us-ascii?Q?v9zN2QGA8nu3cZ1iEi9RNx8Ssge8V+QBivvn3yXhSprcjj8cDgKdZtm/IGAM?=
 =?us-ascii?Q?Qo4Zm3O8YZM0arRPajWp6YOX5x0zFWxtW+7iKx56uXNNShFe8UM4ycCsbMbz?=
 =?us-ascii?Q?1FYSdSyPLbNAtTTKF0k7kVWcpY2FXUn97ahCrT0RsXJ1NPv9/lvPONgCQ7sX?=
 =?us-ascii?Q?ithr3+gRySkQcLZ5V8ja0uVtL7XF2B48Wt8LViDNHHll+CdbbUtP8Q7V3m3X?=
 =?us-ascii?Q?4duGR/W2MEW+f4Z4975LjfYuNPHNSWsNdCZO4EhkzgmmYO4tyBqnc75igohS?=
 =?us-ascii?Q?9gt3PfRyZUXos7g1dqzceYNQQYVm4zr51BiplwAnBZO/tX8uL0HfYU45TOHx?=
 =?us-ascii?Q?Ogk94NxyJOvOdjT+vv71I/sKas14NMeYw+jWGGhZFfEE8kDnumpyN1nCWtxj?=
 =?us-ascii?Q?QIcuFswYABMYgc8JEwe81Ryd08jKVi1nnJflBSgPvLqqfvBC/3Bwk1DrYHwy?=
 =?us-ascii?Q?kzTsx6EP8pF0uVMjhR3yEHWozi6/EE0VujH4RpXo442msvmTFtuEi+fu5esp?=
 =?us-ascii?Q?TVRjmK0CdQO5obm0PkKtZpVvWzgxJtho5Yeq1PQIjnCSrZr1kysDj7Cf23vs?=
 =?us-ascii?Q?VLny5xiRLNuv9JZYMx+i8PlVzQxlI0Vxocwt1PUddWt5pfLzaU9ZW2qdsdzy?=
 =?us-ascii?Q?0yksTq30CvB+WC2ldmcKGxZrHr8keII3QMPt2FqIKP1ZfEWlCOHV8rJ8b2vD?=
 =?us-ascii?Q?DefwSgcNoLQRehQ3NUC3waHX6lFx4BOLLKlr1xv0D0abCqHL1Q9d9d5NDD2A?=
 =?us-ascii?Q?IiSmtSXfFGpMayjL+sc966dVCnvz3A8Vmj0z91Mu1LY1rjfiYeHpSuglS6gP?=
 =?us-ascii?Q?G+0T42mLqwpDGU7Rx8AwyBt1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f054ccad-7894-4d70-d046-08d988db5a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 15:09:54.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+b+NuA9Kxx4KRMoeVeywi1abnCB1GgLTjENKiqv5FyRSSu3UNP7w4ZW8uI1T/4BnyYSeh6bxdR+D3Piw0d04hVt/iNs24IN9VEDQTnSYx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0479
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Oc=
tober 6, 2021 6:20 AM
>=20
> The validation on the length of incoming packets performed in
> storvsc_on_channel_callback() does not apply to unsolicited
> packets with ID of 0 sent by Hyper-V.  Adjust the validation
> for such unsolicited packets.
>=20
> Fixes: 91b1b640b834b2 ("scsi: storvsc: Validate length of incoming packet=
 in storvsc_on_channel_callback()")
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
> Changes since v1[1]:
>   - Use sizeof(enum vstor_packet_operation) instead of 48 (Michael Kelley=
)
>   - Filter out FCHBA_DATA packets (Michael Kelley)
>=20
> Changes since RFC[2]:
>   - Merge length checks (Haiyang Zhang)
>=20
> [1] https://lore.kernel.org/all/20211005114103.3411-1-parri.andrea@gmail.=
com/T/#u=20
> [2] https://lore.kernel.org/all/20210928163732.5908-1-parri.andrea@gmail.=
com/T/#u=20
>=20
>  drivers/scsi/storvsc_drv.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index ebbbc1299c625..4869ebad7ec97 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1285,11 +1285,15 @@ static void storvsc_on_channel_callback(void *con=
text)
>  	foreach_vmbus_pkt(desc, channel) {
>  		struct vstor_packet *packet =3D hv_pkt_data(desc);
>  		struct storvsc_cmd_request *request =3D NULL;
> +		u32 pktlen =3D hv_pkt_datalen(desc);
>  		u64 rqst_id =3D desc->trans_id;
> +		u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) -
> +			stor_device->vmscsi_size_delta : sizeof(enum vstor_packet_operation);
>=20
> -		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
> -				stor_device->vmscsi_size_delta) {
> -			dev_err(&device->device, "Invalid packet len\n");
> +		if (pktlen < minlen) {
> +			dev_err(&device->device,
> +				"Invalid pkt: id=3D%llu, len=3D%u, minlen=3D%u\n",
> +				rqst_id, pktlen, minlen);
>  			continue;
>  		}
>=20
> @@ -1302,13 +1306,25 @@ static void storvsc_on_channel_callback(void *con=
text)
>  			if (rqst_id =3D=3D 0) {
>  				/*
>  				 * storvsc_on_receive() looks at the vstor_packet in the message
> -				 * from the ring buffer.  If the operation in the vstor_packet is
> -				 * COMPLETE_IO, then we call storvsc_on_io_completion(), and
> -				 * dereference the guest memory address.  Make sure we don't call
> -				 * storvsc_on_io_completion() with a guest memory address that is
> -				 * zero if Hyper-V were to construct and send such a bogus packet.
> +				 * from the ring buffer.
> +				 *
> +				 * - If the operation in the vstor_packet is COMPLETE_IO, then
> +				 *   we call storvsc_on_io_completion(), and dereference the
> +				 *   guest memory address.  Make sure we don't call
> +				 *   storvsc_on_io_completion() with a guest memory address
> +				 *   that is zero if Hyper-V were to construct and send such
> +				 *   a bogus packet.
> +				 *
> +				 * - If the operation in the vstor_packet is FCHBA_DATA, then
> +				 *   we call cache_wwn(), and access the data payload area of
> +				 *   the packet (wwn_packet); however, there is no guarantee
> +				 *   that the packet is big enough to contain such area.
> +				 *   Future-proof the code by rejecting such a bogus packet.

The comments look good to me.

> +				 *
> +				 * XXX.  Filter out all "invalid" operations.

Is this a leftover comment line that should be deleted?  I'm not sure about=
 the "XXX".

>  				 */
> -				if (packet->operation =3D=3D VSTOR_OPERATION_COMPLETE_IO) {
> +				if (packet->operation =3D=3D VSTOR_OPERATION_COMPLETE_IO ||
> +				    packet->operation =3D=3D VSTOR_OPERATION_FCHBA_DATA) {
>  					dev_err(&device->device, "Invalid packet with ID of 0\n");
>  					continue;
>  				}
> --
> 2.25.1

Other than the seemingly spurious comment line,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

