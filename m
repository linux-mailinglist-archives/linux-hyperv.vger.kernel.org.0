Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5847F898
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Dec 2021 20:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhLZTtq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Dec 2021 14:49:46 -0500
Received: from mail-centralusazon11021020.outbound.protection.outlook.com ([52.101.62.20]:62715
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230380AbhLZTtq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Dec 2021 14:49:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4LvdNeK4d7q0SM1G0/NYFhuTHr2nR9NiT6zXmqMjQDJdIcAJGQVET7fBCtiDNcwsk+d+roh6pavo9sW8dT7tZkyte6tJtJnsGrDMEqPK//NqxQQK7KQ8bwawMhZZMUdrbkDvmunQkzE/WyDkV8kpJwcmqTkGZUj/b6dtKAJFR7bPcmMDVAAH2P/tXVSw5IB28Ramidi15/pSbUofffudEhO9gUMG7sW0OWMBybTLeuHV2U45y7pu4VGN2hVJgmzfKexzbr/SYtGtbRzEer6eMqkjlcQud6IRYnzsGu/mcz84R8zp8I7aYXUkKEVDdA1g2EoIAj/QHF62aM4q4QO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jas4/nn6B+hlOZdlspPMLAQg2YeIHN3yBg67UC2i1sM=;
 b=Gup4IdTj5NWlDvvlgdWWG2svH+r8ErK7u3nhcqyfv/wX0kqcv29vP5YsBrZLmPR9wqJAheoN1cEwq4MT7tAW5+zfx6S901BsLpLrDGbqxPVuwp+lxUGV2EuRsMyjuaQAhEhmSyLIc5ui5SwOgIRTDS9XsLxwtam3XOKW0UQZMUHqKNI9C104h6/4hvwQpromxhszv1Y+nxuZoA8T14yrS5I/o9AAoXrpbYwKXzHEiny2ocfFlhDgH6gDDMFa5eCt7EUX8uDFoB46n8rwV/dPQsIStvZjBsl6VP3KKYHnNnzRNzCP1QyqlqNt7W+y/NyY3SA9a3QrdBJomwCih5VA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jas4/nn6B+hlOZdlspPMLAQg2YeIHN3yBg67UC2i1sM=;
 b=EL2RaTytCiEP/Us5EEqW6QQncvsBltQamuThPiNNFbrldY1JsvUFQTjAXXYUXsffFHP4HjgEn8nzsr0E2ytSTidbT//qKBDBidY2TIgDUNiZjqHTmCAUnYB6cYEzqRX9HWSptkZuPPpmK0cETBz2NRsiMm4XzDAoJeBRb0ZQFfQ=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by DM6PR21MB1451.namprd21.prod.outlook.com (2603:10b6:5:25c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.10; Sun, 26 Dec
 2021 19:49:41 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e9ea:fc3b:df77:af3e]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e9ea:fc3b:df77:af3e%6]) with mapi id 15.20.4823.005; Sun, 26 Dec 2021
 19:49:41 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] scsi: storvsc: Fix unsigned comparison to zero
Thread-Topic: [PATCH -next] scsi: storvsc: Fix unsigned comparison to zero
Thread-Index: AQHX+L4ius8Cu87rN0aoyi1tB0wxw6xFMFXg
Date:   Sun, 26 Dec 2021 19:49:41 +0000
Message-ID: <MWHPR21MB15936A0B092F7467CC18B3C1D7419@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211224120216.35896-1-yuehaibing@huawei.com>
In-Reply-To: <20211224120216.35896-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a9adfd41-d859-479c-82b1-38befdd60473;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-26T19:43:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e338fbd-edea-4f9b-06b2-08d9c8a8dbd0
x-ms-traffictypediagnostic: DM6PR21MB1451:EE_
x-microsoft-antispam-prvs: <DM6PR21MB1451912F221A1E6BB57ED67BD7419@DM6PR21MB1451.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5FtTcstlr+Gt6A5km8sL6Dx2vh/Dhd2qgfOxgIzu1+nY6BsN4xy6hHpSfNXjwVmI841+dD6nQb/4s6pUnUaCLgtujXT5DTxz74Ch7poaQWGPtsKHcAEitq0weNDNlaqg16FpbYEZXfAUNyoVUU1R9ZfDsIpIEag4n+Y4BxbZ+gXt0snh1WYaCNXszOnVRQ7bhOowa0iyamJ1aSXMzpfAJrT8jY1Nlv0rZqvBrDIYm5Q1vGEex4T9MEsa3vV3l3cozHi+X6VXm81ZJx3himhCEsIOjQRwHEWnZw6oJ4MhMpL0khfqtiJ1ETqwPEqfH8j/iem2wHOhN/rKELlihBx9N79X7Y7Fdq+vsK7gtyPyhxT5lni5J4EB8F/Hjw9/t/r6rdFOced3nsFdO6NwQ0luvljy8ubERrZJ79UPmiV+58NOZNVZMWSkLekeyOkO69vx9SmqOTx2zDVHbEB6elcGtUxpLYpkoem7CGTOOeWDZjrZ1nVI8ycy2cNk4vDHw5OVJFHUwqr3TOIiFyMtFvzorBjfTsScrQJgjHY7jlNzYjSyP0zW0YDRmvrdHHPiJgLjLbLeETVR4BS+yVX8T1UYHkJ4ti88+oCbKxB3R9hIzeCKCExF82wp+PY4PIPVm/oK1TXNSU/Xip7MNpNw/QdhgK0tUEgbV1en77trnaKNeTFr5FI5K6J3+qKjqU5eKmL7ORA52GX7vWTengn8FfMTXQyQUEJ9Q5GiXygK85whEigrOpt1vFuwwtbHJfKoT657e7EQBB4Co3SQHTJl6KudA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(8676002)(82950400001)(2906002)(66476007)(8936002)(64756008)(66446008)(82960400001)(52536014)(76116006)(8990500004)(66946007)(122000001)(38070700005)(921005)(38100700002)(6636002)(26005)(5660300002)(54906003)(6506007)(33656002)(55016003)(316002)(83380400001)(110136005)(7696005)(71200400001)(9686003)(508600001)(10290500003)(86362001)(186003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zrrm7fnDS6+dSJkS2dI+/0CvsldzMNbHZc7P45kAMW0xRGfiaTnEAkvqK6eS?=
 =?us-ascii?Q?dHVGKNL/RswOnKbXXttW/dLL0U6bTXCl7AsANAkJ/QtI+1kNjeDSi3yKfxrC?=
 =?us-ascii?Q?oQYKYUaUZgAXyXmjipDwa/8b50Qj/6t0FlicfT1+Xkmy6WNrQ3zmwy1hwtm0?=
 =?us-ascii?Q?dbEZK+OX5aStchR42xrMsxVCRVC8MPjL5YO3p8AohUwEAihPV+l6rdL0+AdO?=
 =?us-ascii?Q?FYlAmbvrrg4MNT+oA2LikIp6cs9koKNpq6UOdtpnXXkdgR9TVsMTCIqUCJau?=
 =?us-ascii?Q?CHdxTJlEJFQ+Na7eLs8Ofcb1c2CfEjR9sDviJaTMj7+3c8VHLIRoeBL6ITiM?=
 =?us-ascii?Q?OBhKz1yFMxJ3AJV04i5HHqQUv42R7rl8IbDC1WC2z5Lp6kpuZW40UNsBmsCc?=
 =?us-ascii?Q?kWII03wvLm/xwGBNbhFyGqz56LKEtLnjph3rSoYIQiXoOx9PkyipRl+Jq2/O?=
 =?us-ascii?Q?abjDLf8qX1ePxqPBABmR3y8/hRR8S+plxsVOjHXw8YLnss+htdgZcn1zMETv?=
 =?us-ascii?Q?yHeJI7vosKnQEPg6tP/LmuIugsP/RxEyMPxiNXFqOx+hBKxIZGCLWVG8eMcW?=
 =?us-ascii?Q?zHU8F1+SB/UawwdbMQKsr4NEHcTno82R6/9dBSjGVRW9FH19lc8BzlpvC1I9?=
 =?us-ascii?Q?m5dBJlgg5OxwsShCMvi7xF1iN578Eoa7W3NJuQCWYSD+JOIsXbCTdEiaB9j3?=
 =?us-ascii?Q?3AfjcBOEKyhZ8Ifl0SSX2F6Il7ssPCi6kb1leV4tDNbTEbrxD+OQBEzhve7R?=
 =?us-ascii?Q?16YVkRY8c8Hx+a9xoevBGVzv5R6l2hv1susvPOT9pQ6NlmzkWE2wqpPpGqMW?=
 =?us-ascii?Q?kWBIDfRW5zFLggwyByoN63iRMGQoHIAeyPH/j2sMcZL0Ni8l1st/8APSZM7t?=
 =?us-ascii?Q?AvoJeLHTpfGT4zI9NwdQ9jjD+q1ndDBhRcZAZ+NaMvB8Y8lp/Mg5LA8Xo1Bb?=
 =?us-ascii?Q?8RmGH59UIn8+JZyQTjz3v3ZCaIQMwv2+B3qJqc2C3UPj+Rmm8wsadkzsspSf?=
 =?us-ascii?Q?uDcrqtj8mkydeXim2ckg9bkhaZDg1NB13OZn8bbfPClDqDZQRhaqeE4B6M4X?=
 =?us-ascii?Q?0OknK8EYc2ew2+cZ/yWg+s6ZUIb5fz4b2wltqaQGammQQqpGvlFk2ti44od3?=
 =?us-ascii?Q?U7Ka1qK867Zm0qEmaEQzl13TU/nXswkLNEreTgCtgrRP3WB3n2ZQs3JqKafF?=
 =?us-ascii?Q?1GrFH3C2yTHURrzX6MYevL3+BkR++Dq0Ab5rYWTt3g1DbOv525PpuwCfKAxF?=
 =?us-ascii?Q?Jn/qE/OpU3zyXNwMEqfqs8bJzTixisIuE6WEqrKEDaVoI9DNC9moazMgYbT4?=
 =?us-ascii?Q?ad+DSoNAl7+ZsZWkOeP2UGy28z6TMXyW/HxfP2Ot9DG4dI0CZVuzKiSI/1Mu?=
 =?us-ascii?Q?bv2+00K+CFqpxu8blQ5IR6WsdrFCOsMIrUKLrYrYKWI7psYeqSRbpOex7BzB?=
 =?us-ascii?Q?Sg4NbZ8bUCbEFQzEUXune8OBYGBt5wVjtl1K7G6hgS23W5xWl4xfirwMmlUs?=
 =?us-ascii?Q?Crjib9/8QngKn1un+cvuJKFhGqwuoqduKXBEGp/X52TBfCmzYeDehM2p3Os8?=
 =?us-ascii?Q?jfN0TRDRdhkOwhxiXau3u8A0k9qg/DgmY7VAqnsSCu3Q6Ip12bzTU2JogWJ2?=
 =?us-ascii?Q?CuIeTINeeD3rpOP1vcKroE7Yix2kPjWJt0D1JEk/xQxCb9SFchrq9qxPj1cF?=
 =?us-ascii?Q?NfgLvA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e338fbd-edea-4f9b-06b2-08d9c8a8dbd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2021 19:49:41.4440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQeB8HXXdNMCrBIXvKrKgc97yz6/a9wztj9zRE1T3ccQHyRe9247nKY1BwS18l8Xgne1Uo6uK1rantKQ6J9hT9wP8xitOms06X6PAWHzlm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1451
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com> Sent: Friday, December 24, 2021 4:=
02 AM
>=20
> The unsigned variable sg_count is being assigned a return value
> from the call to scsi_dma_map() that can return -ENOMEM.
>=20
> Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc=
 driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Good catch!  But I wonder if a simpler fix is to just remove the "unsigned"
from the declaration of sg_count.  Then we don't need to add the
sg_cnt local variable.  A little less complexity is almost always better. :=
-)

Michael

> ---
>  drivers/scsi/storvsc_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index ae293600d799..072c752a8c36 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1837,7 +1837,7 @@ static int storvsc_queuecommand(struct Scsi_Host *h=
ost, struct scsi_cmnd *scmnd)
>  		unsigned int hvpg_count =3D HVPFN_UP(offset_in_hvpg + length);
>  		struct scatterlist *sg;
>  		unsigned long hvpfn, hvpfns_to_add;
> -		int j, i =3D 0;
> +		int sg_cnt, j, i =3D 0;
>=20
>  		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
>=20
> @@ -1851,11 +1851,11 @@ static int storvsc_queuecommand(struct Scsi_Host =
*host, struct scsi_cmnd *scmnd)
>  		payload->range.len =3D length;
>  		payload->range.offset =3D offset_in_hvpg;
>=20
> -		sg_count =3D scsi_dma_map(scmnd);
> -		if (sg_count < 0)
> +		sg_cnt =3D scsi_dma_map(scmnd);
> +		if (sg_cnt < 0)
>  			return SCSI_MLQUEUE_DEVICE_BUSY;
>=20
> -		for_each_sg(sgl, sg, sg_count, j) {
> +		for_each_sg(sgl, sg, sg_cnt, j) {
>  			/*
>  			 * Init values for the current sgl entry. hvpfns_to_add
>  			 * is in units of Hyper-V size pages. Handling the
> --
> 2.17.1

