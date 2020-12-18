Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0118E2DE639
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Dec 2020 16:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgLRPIl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Dec 2020 10:08:41 -0500
Received: from mail-mw2nam12on2123.outbound.protection.outlook.com ([40.107.244.123]:48746
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbgLRPIk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Dec 2020 10:08:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8OQ+6WSUwdvW9oyjSXdv5ei/Ok3YpjJktP6dgz1jYvsedjUE9cDrYHvec5zqkeiq8nRsUvXVkzspigK6HSC/SV9fyIr0Tu+bCkyT+SqqSi08Jxo/YUFePLHo8bQftTzlJagwMl0m7VI29YUGx4eMFoyYHHfT1Q/eYzZADZUaL9ggJJOklF3VY6rd531VoV7ESY5Mt4hu0AYKtvkMIKGAQZv6uVunfbKFU+bubRxKzCcqMfsjEGNhZF81v/Bsyg4HzB/Lxu87YWLTKP/PuA1E8cYQ9okim73Js3oP9oWi++Rk6qhq3jqPZ3Vw/0f5Gwg7OzLy7NBBJVac2NEDXDwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSjVd3dGh2NwivEOw/7NBooS/F3Z4/zRjKGqE1gXmDI=;
 b=bn13maVMokWi7nyfJmQlLnW8NCU9DF3K9nkaMdb5LnnU6UU541NbFiKvRdOoKtMti5BlreH8GI/DrMSdiDIJ80Zz5G6kIFlvMak+RL8hxvn4rSkZNSClDs4hglp8LnBDGrY8VM64lY3lNSx+hF2KhyzNlbs3mU6aq8V0jptil46ZUMwRK+was9CSnMSqe3A7HTfXqc80KB8Em+Fe3DA6AQEIQVhemaVf5H9HA0Q8w5bd5huWPFOafjR0l5a3NgrYv5PS2B2V3LmXGlqOWd4CFVMEw8jAzu19Db0uvSjzORnm4kpAYVXe+dJ7Q30gAjDHXwCT55RWh5zBWqrcK651tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSjVd3dGh2NwivEOw/7NBooS/F3Z4/zRjKGqE1gXmDI=;
 b=cEl43mF8SdbPB1kHhzxg6tX6f0JxaoOxBBdoCoHOzejPR+AMFIvNsW3mjreMU9bM9n22NuhIX7BLfs5kN2CyjkW6W5Y/gsfPSEWwSzxq5NsRovTMVPGjZniTFMgFtQqCxkftcCvdAGBJPONWLH1hUPco2H3x7s7y/fLtVWJYYVU=
Received: from (2603:10b6:302:a::16) by
 MW2PR2101MB1115.namprd21.prod.outlook.com (2603:10b6:302:a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.4; Fri, 18 Dec
 2020 15:07:52 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3700.013; Fri, 18 Dec 2020
 15:07:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH 1/3] scsi: storvsc: Fix max_outstanding_req_per_channel
 for Win8 and newer
Thread-Topic: [PATCH 1/3] scsi: storvsc: Fix max_outstanding_req_per_channel
 for Win8 and newer
Thread-Index: AQHW1LPvPZ56fjBVbkqBx99pNtyZpan89Xeg
Date:   Fri, 18 Dec 2020 15:07:52 +0000
Message-ID: <MW2PR2101MB10521DA0EE7FFDB533C7C574D7C39@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
 <20201217203321.4539-2-parri.andrea@gmail.com>
In-Reply-To: <20201217203321.4539-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-18T15:07:51Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2154cf1e-541e-47c6-843f-e2e2f481e485;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30d636aa-d8aa-4b7f-3b9e-08d8a366b144
x-ms-traffictypediagnostic: MW2PR2101MB1115:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1115A254172404CD70C52F5FD7C39@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgNnan3xvSJC6kDi6qnnPYmCSea3N2fKc99WfJYElO4Shtbm9vlnIZIH4kX0c3ngwbw0U1nh0nBBzetqUFkta5ARt3Fg1A7VOnUrkzDD16i0gVojFdy8l08RQFFPUBUUq5TdLrb/9f2yIzKvTFUWkf2o7+YG8DP+cGI9/hE3AcxITwCyBS183gfpvfXuPzdqlyxj+f1vIAVq3JaV+43wMJRH41UmVqnE8/eXQFRIXMB53TUE5k4J9hyCq25i6NB9Pb3PIHLMBcy71X+on/tTbsXRNzw01bB71FeabqZ80/4kpkzYoczuVPKV/1c0rJfv+cAxdiejGoMPE8IYeONfkMFSyQiBFZlUSbsHPDQdTZXlBWNTO74okiPApLQNsmXLP56TKvk0ZI/2E/4Ko7mBMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(6506007)(8990500004)(9686003)(8936002)(55016002)(82960400001)(54906003)(110136005)(10290500003)(4326008)(5660300002)(76116006)(2906002)(83380400001)(26005)(82950400001)(186003)(66446008)(86362001)(66946007)(71200400001)(64756008)(33656002)(478600001)(52536014)(316002)(8676002)(66476007)(7696005)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xkLuKH0e9icePnMYhhMG8ZvWZiXfOU1NRO0LMEK9J48DxEmRrB0diIVYkdKQ?=
 =?us-ascii?Q?P0ekAvYKf9kQj65/7AEA9P/2CC20tEP8oesY3s0+ZHAbxOnYLwbgMscn822M?=
 =?us-ascii?Q?NI2uoCke2bH+vzqGFnmvqUXgOxPMJ8OwpOVtTO9MpUWsfVHY2uA3RUOuv1g8?=
 =?us-ascii?Q?fdbzECgp89/2QqmoAQFXvQCAGPueBBTZdcshBuOL60KjGv13mq/fUFtcviqE?=
 =?us-ascii?Q?t0wzFgYhnbskg4xsOCOruX4seakWTE0H0ErT2yVD+5Y4ZnGG7QIugxGS/YG0?=
 =?us-ascii?Q?GFEhnHN2yPNTcoYO3tylHTPE/p2K03d28WDgdpAAZ7CVEDdgnQuJ/MTpbJxy?=
 =?us-ascii?Q?+XsFYDwSA9ZNqso4ujKSrYmxRpgbUgcmXyEmU7RMcWx0/ptCgnhYfU9qad3c?=
 =?us-ascii?Q?UFsKqjenRnrGMR/ehLPd/vnj03u2JSsgmCw8tAtA/sBW4A7034yjMdT9GKfR?=
 =?us-ascii?Q?Qen+Z3+BXYNKSgQsw312IL4jn5QYMvI5JqpkuCgdEvXHmDCmugP4jcPSlpYl?=
 =?us-ascii?Q?nQ/e4R43vn67E4ShgYWDZMtgwiuE9BtCYKO4rbHIts0xNumMrq+m/hiqFPMF?=
 =?us-ascii?Q?DvQKS4BcrTqGo0FqMA0+zNLGvEwPdV5VHq4qqrZvE5D6zFlVCSL3TZpfeS63?=
 =?us-ascii?Q?1//Sb/RtLc5Mtlerr6s51FtieRz4INdJEeQjZqib+1G/jQEKSdX37oMrLuiL?=
 =?us-ascii?Q?3RoDU0ScKshNXGYbTkMMf8p2U0s35Us4Sjf7GyEENIYpymefdB2rnte8dSY0?=
 =?us-ascii?Q?jYZrYQZ/5zFequ7AHpKt65mhTIaBoPqmRLfuA82M0KY07aI7E7mwnTPwcb8R?=
 =?us-ascii?Q?JXD2oxji+MdyJa/RO3ewO8pce0MXa/iI4vezMhsYKq/3Et6i3bE/4w2guWob?=
 =?us-ascii?Q?BlsDrIY5nDr07iHx6I5jlpvyOZizTzY1SGS+LZEeHZwxIBJIuzDMAK67SF0m?=
 =?us-ascii?Q?E6fnABd67NoI6NSaWD8JNZ35wCLUL3PnuomfPu/XPTw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d636aa-d8aa-4b7f-3b9e-08d8a366b144
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 15:07:52.7416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tcN2uWZiFHNgUcRcEVnP2dejIA1EHwDk+3deytNgDBaHPNp5f0hv7t3UZGJ7wtncVZoa0ar9fP7V0UqvRQMohkAu2NUr0OJibYqosFau/Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Thursday, Dec=
ember 17, 2020 12:33 PM
>=20
> Current code overestimates the value of max_outstanding_req_per_channel
> for Win8 and newer hosts, since vmscsi_size_delta is set to the initial
> value of sizeof(vmscsi_win8_extension) rather than zero.  This may lead
> to wrong decisions when using ring_avail_percent_lowater equals to zero.
> The estimate of max_outstanding_req_per_channel is 'exact' for Win7 and
> older hosts.  A better choice, keeping the algorithm for the estimation
> simple, is to err the other way around, i.e., to underestimate for Win7
> and older but to use the exact value for Win8 and newer.
>=20
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> ---
>  drivers/scsi/storvsc_drv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index ded00a89bfc4e..64298aa2f151e 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -2141,12 +2141,15 @@ static int __init storvsc_drv_init(void)
>  	 * than the ring buffer size since that page is reserved for
>  	 * the ring buffer indices) by the max request size (which is
>  	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
> +	 *
> +	 * The computation underestimates max_outstanding_req_per_channel
> +	 * for Win7 and older hosts because it does not take into account
> +	 * the vmscsi_size_delta correction to the max request size.
>  	 */
>  	max_outstanding_req_per_channel =3D
>  		((storvsc_ringbuffer_size - PAGE_SIZE) /
>  		ALIGN(MAX_MULTIPAGE_BUFFER_PACKET +
> -		sizeof(struct vstor_packet) + sizeof(u64) -
> -		vmscsi_size_delta,
> +		sizeof(struct vstor_packet) + sizeof(u64),
>  		sizeof(u64)));
>=20
>  #if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
