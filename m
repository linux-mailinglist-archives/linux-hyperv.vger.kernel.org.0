Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299D72C7A13
	for <lists+linux-hyperv@lfdr.de>; Sun, 29 Nov 2020 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgK2Qry (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 29 Nov 2020 11:47:54 -0500
Received: from mail-dm6nam12on2105.outbound.protection.outlook.com ([40.107.243.105]:4160
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727058AbgK2Qry (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 29 Nov 2020 11:47:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT4zL5Wl5XQPydVCWSOuCy8zp6wtA41s1LjEgXvI9makORASyCGcR3K6t1oG1mka6EmVALA9g/tfRjEwt65Bc68p+tLZisFBl3ezMGUU0H89eOk/w/b/YQyTf6/wr7eKzrWiC/3Km6L17+qcbvThef+Sa7Qv3FYcE8D41Wk7+PJLaSVhL7thKg0zH2JIrZkis8QdFfTakSJwj/C/EiLhUQNooYKwAf85K6Beb56A/YZTPAMtTkNUnB8i7+yixjSd8Dpsi+oWilovJHGLb6SHdeNUtc/gpTzkfv7ngC/L7oXDYhyztX776fYetbOFTp3yNDcr3Q8dhIHyGYZkpnSd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlY4Ok9a99hYK9J1TIQSIiazLHICcjWa0opF3qJMDvw=;
 b=OSthCG8fEGplzRxBoHyRGhTWofnUW02p2HsGSheBiHylI4fzzjx7omQtw5JOcfvRHQejhLRwaJBLB0PIyu88KGA17Pg4bbz5srDboRSNk6yDEOOUy7UAd6FTfI9yLGusLook22W5YJXIx7pTa+mI/MrjKR0jfzIip0XVTaWrk+pm2mLFD74kwUwS9+ascxrsgdOv6Xb5FkLoj1NDGreFgGOHhT9sAoCSsdYpB4KCpHbOQ5YwT23yUsnfPZj8oJrNOopZS+jyGPUT9ukjW5p606PL+tLOuFZR6GPXuoUGVtWL1uRe7f2dHWaivdJZ3uxZ5NK5iFZUSahrhx+Fpj2doA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlY4Ok9a99hYK9J1TIQSIiazLHICcjWa0opF3qJMDvw=;
 b=EhiVNvAkZA6yn5/9baqkmrivINETkIjECKm2Cha3/ZtubNQmq63eSL3KYLTiVHGju2GzFqSYOwNid4Lfa80x1TKc2qMkx6l+jxsMtez3wUejG1/BIJ1lfxKn8lYkYGVwXNdNectNzQzMTes2SCyKd3LfxZLYnLrnoGsA+iU4TvU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW4PR21MB1908.namprd21.prod.outlook.com (2603:10b6:303:7b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.0; Sun, 29 Nov
 2020 16:47:05 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%9]) with mapi id 15.20.3632.010; Sun, 29 Nov 2020
 16:47:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Long Li <longli@microsoft.com>, cavery <cavery@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Fix error return in storvsc_probe()
Thread-Topic: [PATCH] scsi: storvsc: Fix error return in storvsc_probe()
Thread-Index: AQHWxGk0UiiKcdIoW0ug+nQpObRPi6nfVSmw
Date:   Sun, 29 Nov 2020 16:47:04 +0000
Message-ID: <MW2PR2101MB1052867F6E39E77E165B0B55D7F61@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201127030206.104616-1-jingxiangfeng@huawei.com>
In-Reply-To: <20201127030206.104616-1-jingxiangfeng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-29T16:47:02Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f63e8575-20ac-4bab-ab80-f79a590a8614;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 046753e0-2a46-4c16-2183-08d89486672b
x-ms-traffictypediagnostic: MW4PR21MB1908:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB19080627B1604DEEA4D641CFD7F61@MW4PR21MB1908.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MqEBsuZOGQR08Tc40ltyd3EK3K0nFzXGtOpH2HmLWfwBhFGNsFiBS/u1mzgCT99l3tUOf3G7lD55puWqgEeUGYAyFabOcAWs5BN7XoM4TL1ma2RXW5PsCuT8EzZW6dFXQPrclBSrXEopOKaOQVuwTF2agEqJyGl4ikVrLn8xGH2xQzXgWY5MKVG+6ZkTDAeXLtiszNiZgk0Ab0Ljhx+jK8O3LXbMufrNtL79YdcBl4Y4cpZMd0z1Nhup7nYkbSov06GnVHL9B5vuQMpJJSXImrEjx7wNjKv3aoAtKTglfpBuPPIXXovf0OpxuerRNRUp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(316002)(110136005)(7696005)(8990500004)(10290500003)(82950400001)(83380400001)(186003)(54906003)(86362001)(52536014)(5660300002)(71200400001)(6506007)(66476007)(478600001)(2906002)(33656002)(66946007)(4326008)(76116006)(66556008)(64756008)(66446008)(8936002)(9686003)(55016002)(26005)(82960400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+NlB0yCGiBdJnXZjwvqZm5TSLlZVQdFUR3qcHlN3wiP8yh7Rss7Hdk7+3xr+?=
 =?us-ascii?Q?/ppIustwzly91OCbbDGmt2RDe5mjrUWLDy0hnBYUodOOLlHkQjWA0npbsF/K?=
 =?us-ascii?Q?SAf6aPWrcwTQjkUJJrnV68GA98K0TyIyZSqn5P74TjE0DDxvZJVHkpK7LRR1?=
 =?us-ascii?Q?0cWSMG2Q1zPJgAd7tHrK3+a460VB4l2WfTRamNdem79rZ1KVTuiZLSpEBR8H?=
 =?us-ascii?Q?Xx6l9+aR+To0F54LahAoeqVXX2U/AK782LkLuBEGEe/MyG5qPPebYy5LzcFL?=
 =?us-ascii?Q?6SOxXTBhLvCM3iQJXkW6g7cTLXg+kkXaPVZPXMZ3L20gV2QinBL3NsSUqz0S?=
 =?us-ascii?Q?jd7gXyRc48Vdy0uplBfRssFeJfk656fvKMkxyiu2yhCSwosxUo+J87hMA3v5?=
 =?us-ascii?Q?ayZU6AdIOBzY3RI7Z+3e22Ab9Ku6xPXqiIb7FlEkBQCA1iEn76P4nl8VJrZf?=
 =?us-ascii?Q?4u41K9iw2L2NhGCuq/F4f9znlATNOjNLkncXGGuUSwUow1IWGA7admG5dG5M?=
 =?us-ascii?Q?yPGQWgGU3au2GrPNY646c/9jvF1VwIUKoLST5acRnGE+M/dDlqD6uL5B3sNU?=
 =?us-ascii?Q?tyai3UUiUhZMVwLQqNnerdPzcQRUsgvmBLPq2znqM9M6DwNU67mOy+SSXHe/?=
 =?us-ascii?Q?X9DPWogis1azCVOQVI4k1C9rM5wapBpWLBD2konLOq4vcP1XIKUb+CeyWwLS?=
 =?us-ascii?Q?ycCpVNUzY0ukHoFQ60PnA39kqBLzArNreK88E2yz45aNOn2KgnrhtTVQIkaj?=
 =?us-ascii?Q?1XWsh1B9hIkn072Pi8WBRbKVztp3JjZPdfL7bzNMpCIYhU3eTfKCmLS5St13?=
 =?us-ascii?Q?7Gt+iRVQnupOACXDYQvz7VM425QqWdTTGYh5A+e11isI1zBQw5uPoDedhjts?=
 =?us-ascii?Q?9cPGnxay53rxwzRq74mZfbKLL3HUK2nyBgY8e0RFIM2XwpyzSo1MNUEXRebC?=
 =?us-ascii?Q?kcrZYz9xgUHv6lN8FfRTCzIBzuH9ilNgLf/3osTPFCE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046753e0-2a46-4c16-2183-08d89486672b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 16:47:04.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OP0/Fl9KIeG1aUo2wpZCnvVse2tb2mW2gOf39FEU/RSv7kyl05HORaN/AT1zZjiSR7UBDyPnmpEyXbKcSi8tFuBPyqxMy+/SIHwfiSHFbh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1908
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Jing Xiangfeng <jingxiangfeng@huawei.com> Sent: Thursday, November 26=
, 2020 7:02 PM
>=20
> Fix to return a error code "-ENOMEM" from the error handling case
> instead of 0.
>=20
> Fixes: 436ad9413353 ("scsi: storvsc: Allow only one remove lun work item =
to be issued per
> lun")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/scsi/storvsc_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 0c65fbd41035..ded00a89bfc4 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1994,8 +1994,10 @@ static int storvsc_probe(struct hv_device *device,
>  			alloc_ordered_workqueue("storvsc_error_wq_%d",
>  						WQ_MEM_RECLAIM,
>  						host->host_no);
> -	if (!host_dev->handle_error_wq)
> +	if (!host_dev->handle_error_wq) {
> +		ret =3D -ENOMEM;
>  		goto err_out2;
> +	}
>  	INIT_WORK(&host_dev->host_scan_work, storvsc_host_scan);
>  	/* Register the HBA and start the scsi bus scan */
>  	ret =3D scsi_add_host(host, &device->device);
> --
> 2.22.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

