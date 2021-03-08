Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352053310FF
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Mar 2021 15:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCHOiM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Mar 2021 09:38:12 -0500
Received: from mail-mw2nam10on2093.outbound.protection.outlook.com ([40.107.94.93]:8352
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231221AbhCHOhn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Mar 2021 09:37:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDn+p7wMRKsUK6aAbDPrBjeze7u9hOGXPXSM/EDwdrmmcaEpbwOWhToq1+kOw8LnUH5/ct+2r20nEKRkkYrZF1JwNt/QnBaWIUgQIIxrU6rgK29EJqaLXmqP8gCgxbm3C1u91MADNgjoXWnv5v9WjOK/oxTspplQRLHI2wRYKGuAlzLlmenz/nYfGTC0osUbZgAS5GTcpPqLPGSCWDJVPmu+n9ccWGG20hZRZCVEtxA4WNqDGeLQ2hGcCPqv5ehO9gzju5aBdyqesS5ZPw+hqS1dU2uYZNHO1q4vtpbSMcsmNpNdpM24Ck5lkD94yPTbu00A5CHI/IBTBXTpxROr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GSqiy3WiK/eIOgMAYpr5/tVSF7geXn8xybswHVmGe4=;
 b=ZkbLFfL23FamHI9Zzh1NACh4uXgORvt818Sk/8mM8liQ+qbqoBePv3XFWthb3zB9k4oT9vlg+bMvkKQ60BNL+VykDgMsrV1VCuUzEWZZ9Q18Soh5pjf/YlqIVADaFOGTctQG8E06cngEHs4vYrGnS1I8qYBa3fEoFVcad85KsKGlXvlWPUCXrzWj9Z9E+clVMeFTxqXlhd0aiiSDFL5eCFCsTy8IGnnKJevklK9RMV/nSMI6Z3U9prWHlLvLqeAXSqJCjE/pZC1rRhqQFZUzTcWiM/imndgkHaxWpWfxzomsl3kO0xAxNJA8RhDj0jrZ7dxFQ6mTbRc3PpRQ15xWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GSqiy3WiK/eIOgMAYpr5/tVSF7geXn8xybswHVmGe4=;
 b=JtxIKr2fnErAuMymqL+6UbjSeGgWoB6lIVjDDsm7M69HZDwx6WunzESTj2U7EM1vxuqlWVeAZ46J/sGQh6Xt8U2a/Zx0OPxCXRPHa+dxlFHAZL2HqBiArVpm8/AeVPM0BgU8BQqv8rM855uWBmWLPb4XgEJV52wZko6jqXVel7s=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.9; Mon, 8 Mar
 2021 14:37:40 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3955.005; Mon, 8 Mar 2021
 14:37:40 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     melanieplageman <melanieplageman@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "andres@anarazel.de" <andres@anarazel.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        melanieplageman <melanieplageman@gmail.com>
Subject: RE: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Thread-Topic: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Thread-Index: AQHXEhZt+ZHc82CPuUC0eGRm1QUsMap6KhHQ
Date:   Mon, 8 Mar 2021 14:37:40 +0000
Message-ID: <MWHPR21MB1593078007256C5155ED5A86D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210305232151.1531-1-melanieplageman@gmail.com>
In-Reply-To: <20210305232151.1531-1-melanieplageman@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-08T14:37:37Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=77e29938-1426-4286-9cf1-f9c0e7db6aa8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f34501c-4b7a-477a-5847-08d8e23fb9f0
x-ms-traffictypediagnostic: MW4PR21MB1875:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW4PR21MB187514E53E337A91ACCCE219D7939@MW4PR21MB1875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N2YF/KX88OsISGo25kYHqBlntQww4brTiLQb0RVHLy4gr0u45feaISfykswCCVo3EFRQrrd7+6+pZexuOrGZDpdYJ7QbtuH5B5dJvzR6EaMfcUBXFeJTvfkbdkA9TkE1OpMWMMhTgVm6mBMD/J7KsF0eOjpYAHxmgtR+WnES5kGmoAb6+lW5UhYF+8kUpcBBotoLKwrnWsyqrJNbjK9nxA4U3bQVTXSZWj5nvCxiZt+xlHTV7P+gzcbYK8yDkEW+3L10syRKxZ4GOf2+8Mmnl7r31djGvwRN/we99Gh9Q8jW+8v2Guv3SQOODRF2lqlyFrAKETZzNHp1I7vEssC4CtLckCP2YvR6M78242YMidf6i/tVnDaaOooGnBDZWlayzKSBqxSyuiXoiKDXZoK5j8HLruevjc6C4XIDQ1fQAd1GAivF84y/N1rBtP2sPqu30SCxfaNcQxr4CQR2X0COCpf+pc82ZHrMr+fxMcIkRPR/6Qyx/lSBwz8yjA+USx6VQ0WViSwwrbXGN7UDQ/kwx7W46oqcFRGcHnnaUk2POVOMDbZrrqGXNXofhJ2A+93u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(66556008)(4326008)(110136005)(26005)(54906003)(186003)(55016002)(52536014)(33656002)(66476007)(7696005)(64756008)(66446008)(66946007)(8936002)(76116006)(9686003)(5660300002)(71200400001)(316002)(8676002)(478600001)(86362001)(8990500004)(10290500003)(82950400001)(82960400001)(83380400001)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3AvC+3Qf5GGBIfQCgEkfO+yNKVZSa3utPaVPOQjv+JBWYubr5oPt3bfoBmsX?=
 =?us-ascii?Q?AsgPOwQfvG6qBSM39/6kRsV5Xjm8bHdynfrcu+23NXzJguU1dbFw4kErb0gP?=
 =?us-ascii?Q?1LycoGvecDt6HjvkAe8tMssKS8cRyjlg4yI3NeT+kjVLllpZPxKvp6auQ8BF?=
 =?us-ascii?Q?p5YhEtSeaorHk+wYT6rSIPthfuXxGk98hnLUg0eXO6Gjdp0SHVhVrvykJCcB?=
 =?us-ascii?Q?dcQVKD+CwthQ6KYjgKiS1GZQndlvkg0dHV9Q57XcJJK5JwgJqpqwimDySXF4?=
 =?us-ascii?Q?zhyhasIIN+16MNBt4uaIqb9lr6U4RBVwmAAZpT++DDGC5GYjKnHo7tcfa61v?=
 =?us-ascii?Q?TeoptTUPCn4xnSYFoMKyw4ap5XxIWHmhn4wb372msnSZC3Fibx3+c0qoZq6s?=
 =?us-ascii?Q?N9H5jTbTSgdZ+tnA7nrlzkMxLeBRo2f/cMV2G0xGEMIoHTZuLkw4xAMBf5K7?=
 =?us-ascii?Q?G3S/7KSwSfYaPg+cb594DH96U/FEviPaI2tYZRzOZXM7gRzi3hj1YHq3gNea?=
 =?us-ascii?Q?u0W/IcLy72IX6Z3GznI8xn9j0/BaGULj7qFqyAlAO1HcNYaGP2seLSP8zjJb?=
 =?us-ascii?Q?XhMvz4gXS8CFxUYOS4RjKD1BMRR+vS3IofkjuScEBd2Ti3+DPTkO7/tzkQCb?=
 =?us-ascii?Q?S82O10eDTRzcT53aM6TX4+tyGuv3dzyJdlJXL/tbvO5UXBwfQESJ4wAu7Ygo?=
 =?us-ascii?Q?l0i3247nQ1KgvQoagqLEe6G5wrmqnakgXhtoJra+GypXtlkNSsQ2wRkvtEE3?=
 =?us-ascii?Q?1zJWqd4NJlzWx818/iXoOBAQ192+CQdr1GKuXsr15A3cBemMbH1tGanCaTGg?=
 =?us-ascii?Q?rOm7AL5NFvXm6kprEwyD+r6n+CioCSf36mqAxuwQlhTPYu1JxU5pLcpmxq2D?=
 =?us-ascii?Q?ttyhAQnHIG1ejYMDA/f++DnMzChVwN7l7sIbXgA9fm1yRM3YEvet2Y9pSVoE?=
 =?us-ascii?Q?P+4+1Ruyzl7UBmzMRhbrYQQFvRJFUJI1G8kx7yQF1iB02SJ3Fdbtqe4FQ5Xk?=
 =?us-ascii?Q?N2WnGuPQOH+K3Q7eihUaTwZqblGU/wu7LhDhWI91A4Q++zvk2imX4Xw46J8y?=
 =?us-ascii?Q?fbnfAjmvTVdK1Uoj9dMYFkaRqYkdLKnmy3wr6wn1xpqZq205/prltAaM0D9G?=
 =?us-ascii?Q?4B12xdt2xmYncSKoGRZe0Uo1wf3GECOjdjq9Zwi7isywD49VarVDZcz5Jyf4?=
 =?us-ascii?Q?qYn3zJXVsfJjHwKYqoKX2xeVx1pQXqFB0w8LtgZcNcPr2nvm3B5GaHzZZoZE?=
 =?us-ascii?Q?LZVr+AzpDW9UcRpUq0Nj3x1mXAOCbuOjhAADu/Up0DgWzv0Aiz2u3q1a+yDN?=
 =?us-ascii?Q?amRc+qL5poztOWmihZG24PK2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f34501c-4b7a-477a-5847-08d8e23fb9f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 14:37:40.1159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAWLisdI0wXdm27eh0KX9jkByV/renA8sf1ZBV0hO9DQKzOWmPpQDxaVT3s7++SKqPRurLx6NVTvyBRWUY8bJD3ZkBLI2b1NVz8PlwCVODw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Melanie Plageman (Microsoft) <melanieplageman@gmail.com> Sent: Friday=
, March 5, 2021 3:22 PM
>=20
> The scsi_device->queue_depth is set to Scsi_Host->cmd_per_lun during
> allocation.
>=20
> Cap cmd_per_lun at can_queue to avoid dispatch errors.
>=20
> Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>
> ---
>  drivers/scsi/storvsc_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 6bc5453cea8a..d7953a6e00e6 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1946,6 +1946,8 @@ static int storvsc_probe(struct hv_device *device,
>  				(max_sub_channels + 1) *
>  				(100 - ring_avail_percent_lowater) / 100;
>=20
> +	scsi_driver.cmd_per_lun =3D min_t(u32, scsi_driver.cmd_per_lun, scsi_dr=
iver.can_queue);
> +

I'm not sure what you mean by "avoid dispatch errors".  Can you elaborate?
Be aware that the calculation of "can_queue" in this driver is somewhat
flawed -- it should not be based on the size of the ring buffer, but instea=
d on
the maximum number of requests Hyper-V will queue.  And even then,
can_queue doesn't provide the cap you might expect because the blk-mq layer
allocates can_queue tags for each HW queue, not as a total.

I agree that the cmd_per_lun setting is also too big, but we should fix tha=
t in
the context of getting all of these different settings working together cor=
rectly,
and not piecemeal.

Michael

>  	host =3D scsi_host_alloc(&scsi_driver,
>  			       sizeof(struct hv_host_device));
>  	if (!host)
> --
> 2.20.1

