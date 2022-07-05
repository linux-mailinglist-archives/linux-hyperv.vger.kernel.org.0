Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660535675E1
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jul 2022 19:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiGERjR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jul 2022 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiGERjR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jul 2022 13:39:17 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021017.outbound.protection.outlook.com [52.101.62.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4017597;
        Tue,  5 Jul 2022 10:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1qgIikzvyYxyCBMty7jEKdK9TH1760FlPr5XigFuW+AO7qZY/1mzgIyZf3hC2Xh07TjpThhW2Wf6QxfwLfKyITO32O40SAnhgj6WMJM+ncWuCydd1R0YpqUpsL55RNeJ6qX8jMJCTW1yuGZWsq4o5aPo6EAMfHDWIQgptIYt6+5v3utR3mlotqsJGXx9iKez3ACwA4ZP1seahyssx/oXFiDvBX/1fDU/btlB9YfMSuvnJY5+a3fxA8Z4BMnBkGWujnKuCuFQevtLLY/0rVhxFk3YWWmcexB6U+LOviHq8WqA2lGVIdD5xoCv+B6K2ueaxJEY2+EVriVhNdxmT1u0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN5s6RYc7Ez/UXgk2feO2GEz8yfAlMNPepT/OZj//hU=;
 b=jmSBxNBbt8ha0fLqJPR2br6mglOeoAIa/9fltHAsqhKfMe8l2CmYIdqPeGhaiTyicZDnsJoE8UI6dUB85LvuzC/vazZDX3wZ2rTdGscrYd657YvNsp7qz5VgtvWKLPY/9JpGaUXnzpXhX66USJf/csXEUpS+Npl3Y03k9fnoAkYw4/qQh/ZmUnRHiLYLePjIXGQ0OTigOOKEF8JjvnDe/PBQFd+HvZquIEDnpjve1bKlC8olvGSRBeWvE46WPBnX88vSGWCbnWgN9FBzxH/SO4uuZxxRQpo67SvkMOVLi9mYdmXAu3qh80Ssi50zQTQZ2+A9gygDUVpk9DayI7cniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN5s6RYc7Ez/UXgk2feO2GEz8yfAlMNPepT/OZj//hU=;
 b=biG64LQ8bTv/axB8kUbKG4vWFhGELEf542WAFKsNTvOPsZ0/eekaBLgR+BS40u1lFk7pXIUxjmr3+aT0Uby26ywmz53wnzqH4mgSxdrJ4eeIljox/MiSF/BzYQn8AE2Hjbmv2z0HzPtM+yFlmMBOOEdOWiLN6fq9XZHhvPhGDtc=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH0PR21MB2007.namprd21.prod.outlook.com (2603:10b6:510:48::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.3; Tue, 5 Jul
 2022 17:39:13 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::7838:dcbf:513b:d992%5]) with mapi id 15.20.5438.000; Tue, 5 Jul 2022
 17:39:12 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Prevent running tasklet for long
Thread-Topic: [PATCH] scsi: storvsc: Prevent running tasklet for long
Thread-Index: AQHYkIRxnF98098OPUKVFTnw6GGSI61wBk5A
Date:   Tue, 5 Jul 2022 17:39:12 +0000
Message-ID: <PH0PR21MB3025B640046F1F55C80E56CAD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1657035141-2132-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1657035141-2132-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0365133a-cc00-428a-a7b6-f435c1d844db;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-05T17:21:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcb22dcd-8d38-4092-efba-08da5ead45f9
x-ms-traffictypediagnostic: PH0PR21MB2007:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d89VvyyMTHHMr8FJOQy4SPUhwXeoceHGxUovpqA43xvmgRxEXyqNGhtwdl7BDlQC+1+FCdRwngLpK1kPBYvwlcII3gUHPkL3fNxoRT89OBWk3C8sCZZsoFQZXEYxW+NhpHcfFZa+efrVrReStRCXh5yMXD1TwBBcE73zl1a8sL9k1F23qIbPX7kLM0MvJVq2+OfQuN2UGcBMG4ZurHGmifzpFhCc2DJ/8/QXWkxdHlN2pvOLnkdO3I5cPEzHce/AW/23XQzRqe5zik62dBtb7c/8IG2uYEnd/hsvJIoBNZMRKLnzmlRgOcoyMIa85w9C1KG2rbEuDC9NMAdemZfpTe96CLVhYrXb0GicXeLIk3CWkJS5Xur5nVuCDN7tcGk+xopUASah/maHTBotWvR4ccHDx0bY4+J1dGXltKgR0wmuWY+Qi8FTSm8P8M3sMjuM3hqDe5Ls1sc8mb6Lu3zEjXNlU68yuq8mbIPZ/85Z3g5Z1H6W1l+wcS5HaZPgZ0ulwIEoKcPRmTHOlplcOcWR7/ZcbO8bcpb2/qZ7f5ipTCCqIi4417vZKQxceXSPApSK/hx8hfn7DAcSbZet/Nfl7eMsVuOIqqPqe3Eb9EOwYheEmFSsG3+4/If4llNHmsa1HmB5UlVzuKr9oleOPwshe38O81T8G+Tw9rKNP3HkFRd64aMCE7DzWou7852EIzIjMPv7eIzDL3e5lspCtdQGgmL7OqTfLgEkqHUDj7YjrfLFKBhcWgv1ZpS5lHWQTzNYxpiVvi4kLbHeKbikRwY7hHgQkajcHfIyTfO8Ix4ZOsrug7tu7sHhumGQWTqt4V5/dvPVEVHUqqsTV/AXb5aRanflxCRDkZG7fACviL36JOK6VjUa5k4ETU2/HSLLaxB4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199009)(33656002)(86362001)(2906002)(8936002)(122000001)(55016003)(5660300002)(9686003)(52536014)(8990500004)(26005)(38100700002)(66556008)(66476007)(66446008)(64756008)(8676002)(7696005)(76116006)(66946007)(38070700005)(186003)(110136005)(6636002)(316002)(10290500003)(921005)(6506007)(478600001)(71200400001)(83380400001)(82960400001)(41300700001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uV6nQpfsgyNMM/5VyZD3bXfVLQ8tV0dT1qj30Gk8/YZDFCSbMieYTQ0moJM8?=
 =?us-ascii?Q?JC4bbZD4kh6M843jNeFaoyzEgpqOqG2sAAGCS9HqKvY20PtMk4HEV8iJ5q9h?=
 =?us-ascii?Q?KkdG9Sl3ifeE6LWZXiR0o6SsmQE2i+dH7gwvzbjJ5UDBPERO/S3EZ1mizIhd?=
 =?us-ascii?Q?g0udn/EuZQxGuj63fomKygrbv6qRcfMgiuadjeRhil4i3ln+VcSbjn/GTqV1?=
 =?us-ascii?Q?ugXTlu/5nCajeJBqYp0piXSnYOCZadTN+icnLYJk9882OFsaK/SuCKMF+Gde?=
 =?us-ascii?Q?YVi5D8iltlXcbBfrognMz8vGGpBDo/sEjc4pSpS6NwYb5cQASamsI5PYLTOY?=
 =?us-ascii?Q?Mn7SAKIZwSIeJb7psWMilNxAEcn2vtSt3Cx1L+i1URgLOvdqIjnxlmW70Dd5?=
 =?us-ascii?Q?WVRbSw9ZntDwUgXUmdO/mlflC8uodD8t7RAgQRz9c32b5Syb1Nbm5d7oJK6W?=
 =?us-ascii?Q?t0H7RmMxLzh+x/U4aZenevR82YVv3qTY6MMEF27jZsQabPyb4tVg1HvNcJKW?=
 =?us-ascii?Q?uPNSbMjOT+g2yT/y55fwV2etUEYoKa1nq/K6Ajd6Kup1WRSXSgeGcCHPcpKb?=
 =?us-ascii?Q?spjf8QIVdU11cjNK8msK4McqkHh0DitDxZ5FPVi5BvfVucrhoNyeGKhqZSYM?=
 =?us-ascii?Q?5st2KRAudy9qVk4KSkwTDyxegHNdfKYc8lwgKOJ/7fGa6o86u0qH1rv+bXiS?=
 =?us-ascii?Q?ceTV6Wo2DEyIhBWqvUPfYEwt063wrK4l2ODrj45b2zv0f17BQ8t5Cjh+acg+?=
 =?us-ascii?Q?tpqcx6geV5b8zQmtpkYTqbrl669pLDb8ISVzlDU9EqXQZSwuRvzne0ag0x/t?=
 =?us-ascii?Q?c+BVV5A9v2QgVJuNiTpOcnBUUy3ntn+ZihZcfehb8caNip6b3ciAyuYZydKq?=
 =?us-ascii?Q?vDYqi0DpIon/7WDRwU0oRSevhWEuuzrlmmXhRwUw32faaVoemL9GLo5giPxX?=
 =?us-ascii?Q?UhawU8yJsQPElFSYF1/I/yVY3PG3KnaIozKobxVIdLe1KI2NUsI0H45ll8KL?=
 =?us-ascii?Q?cBFpCDYV2bt3mX6dtoYmjhSKxm8V2mBdJCkt0bdewt6Ramo6wYFHGzIja1A/?=
 =?us-ascii?Q?Dxpy9ZGiCnELaCu9tVzkLhAkngIJvCFBZjZEZUK8X8bl5bx6yTUCW5CgW4iV?=
 =?us-ascii?Q?B00lx9ic/2SKe19NBaSsze+Z24B1oEtDX8yzTPGSX8JV74r5+cZ9Ho/PMrV7?=
 =?us-ascii?Q?aGGTCRHUuRn5ngECt8Ujopib+y/QnPBFXvKKIn9gItoWiOhw23XgMYPg9vPm?=
 =?us-ascii?Q?uDRz+aX/W4mAbdOxU0kC6yYCLliPtl3rMj8/zZ+G2a8cEJe81vMxo+M+Av8Y?=
 =?us-ascii?Q?mNEgjWiPnbsMgQTwtEeHKgpNUs+0FPWbv4YEvcPZCZNnK3iE+FcY9949jds3?=
 =?us-ascii?Q?4NFyYVadcpXUsOfCFLhAmwij/RZRQMig8M/3WHev8LGtsQOMPfhLvZ8F5f8Y?=
 =?us-ascii?Q?wGqqKQri46UWZsC9k6rl+dVQYGa4whURjMVEkaAH30++qB0n0HQK1dYkw4Qa?=
 =?us-ascii?Q?rG+NmELy4TpaD4LHpmSgfAFYFBSt191oqCU9GTls57tY5n2w7h7ZPVdmxYRO?=
 =?us-ascii?Q?KDOQN0cRQ2bGqLrWFphZFkUmH64HydGljFaj8Y26Hg3RCaBVMDV9Jsrq1Xa0?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb22dcd-8d38-4092-efba-08da5ead45f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 17:39:12.2082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1cvqcl7IGl01Ta2gcO4kuw1kcCdNJGtr+SOHSt21Q7kW6XQkf+VUWZ0fOk+1iltolYLmYdWEf1AgxCl1+/VyxkMBJjBXHKdVfPdn9qgxPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB2007
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, July 5, 2=
022 8:32 AM
>=20
> There can be scenarios where packets in ring buffer are continuously
> getting queued from upper layer and dequeued from storvsc interrupt
> handler, such scenarios can hold the foreach_vmbus_pkt loop (which is
> executing as a tasklet) for a long duration. Theoretically its possible
> that this loop executes forever.=20

Actually, the "forever" part isn't possible.  The way foreach_vmbus_pkt()
works, it only runs until the ring buffer is empty, and it does not update
the ring buffer read index until the empty condition is reached.  So the
Hyper-V host is prevented from continuously feeding new packets into the
ring buffer while storvsc is reading them.  But ring buffer is pretty big, =
so
storvsc could still end up processing a lot of completion packets and take
an undesirable amount of time in the loop.  Hence the scenario is valid.

> Add a condition to limit execution of
> this tasklet for finite amount of time to avoid such hazardous scenarios.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index fe000da..0c428cb 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -60,6 +60,9 @@
>  #define VMSTOR_PROTO_VERSION_WIN8_1	VMSTOR_PROTO_VERSION(6, 0)
>  #define VMSTOR_PROTO_VERSION_WIN10	VMSTOR_PROTO_VERSION(6, 2)
>=20
> +/* channel callback timeout in ms */
> +#define CALLBACK_TIMEOUT		5
> +
>  /*  Packet structure describing virtual storage requests. */
>  enum vstor_packet_operation {
>  	VSTOR_OPERATION_COMPLETE_IO		=3D 1,
> @@ -1204,6 +1207,7 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  	struct hv_device *device;
>  	struct storvsc_device *stor_device;
>  	struct Scsi_Host *shost;
> +	unsigned long expire =3D jiffies + msecs_to_jiffies(CALLBACK_TIMEOUT);
>=20
>  	if (channel->primary_channel !=3D NULL)
>  		device =3D channel->primary_channel->device_obj;
> @@ -1224,6 +1228,9 @@ static void storvsc_on_channel_callback(void *conte=
xt)
>  		u32 minlen =3D rqst_id ? sizeof(struct vstor_packet) :
>  			sizeof(enum vstor_packet_operation);
>=20
> +		if (time_after(jiffies, expire))
> +			break;
> +

Per my comment on the commit message, breaking out of the
foreach_vmbus_pkt() loop leaves the ring indices unchanged.  I *think* we
want to close out the iteration via hv_pkt_iter_close() in the case where w=
e
exit the loop early, so that Hyper-V can re-use the ring buffer space from
completions we've already processed.

Also when we re-enter storvsc_on_channel_callback() and again do
hv_pkt_iter_first(), that should be only after hv_pkt_iter_close() has been
called; i.e., the hv_pkt_iter_* functions should be matched up correctly.
The current implementation of these functions doesn't go awry
if they aren't matched up correctly, but we should nonetheless do them
correctly in case the implementation changes in the future.

Similar code in netvsc_poll() has the same behavior of not closing out
the hv_pkt_iter when the poll budget is exhausted, and we've had a recent
internal discussion about changing that.

Michael



>  		if (pktlen < minlen) {
>  			dev_err(&device->device,
>  				"Invalid pkt: id=3D%llu, len=3D%u, minlen=3D%u\n",
> --
> 1.8.3.1

