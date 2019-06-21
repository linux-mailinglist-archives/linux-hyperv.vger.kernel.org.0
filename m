Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE59E4F123
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Jun 2019 01:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUXY4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jun 2019 19:24:56 -0400
Received: from mail-eopbgr800135.outbound.protection.outlook.com ([40.107.80.135]:39026
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfFUXY4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jun 2019 19:24:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU7IqQyczAy2oNT3KSa7QaXx+Aucle5sGt8GCjfqZQfZ/Txppqg6nVIUrs/ReVOzdpab1z9UV+5W5pHPx5oAAnCucGmLhs+QpNozXMYlSO/6QoKRlSTUcY+edqR5ArUEKdkVK5K9v+5R8SxJ8CI6VhnbnXBzJofMeyMG1zZ/C7Q9oocqnIIkV7edW1+9atoFfWIxMA8xX5qI+hd4mvTVdnYt1uQJPbboLJAt+y/KVn/Zaj9WZ6fXzSaOZ6IE85gJAqJQnuy8XUTm75TcVpJbnpXiUiUcMtRIcT+1fI8SB8JUNMXOZdsWXaDnMjchYkMR8bpThKr/RziBuBLP/Y49Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vubLWmtWqKeMlK47t8WEhMdr0Batk3JO8VBBrBVeOfU=;
 b=mFY5uS20+dAO+yScPithiEKIyJX933nwQqvN+KBI58As7/3XNxUyXGo4PKmsTWF4PQBpgmyV+ZOg0WjuZioUHZNzSEt7bQBZkjoLf/YA59b3uTbEdTFTdCezMQ5bB0T2r+t/P+KdeACMeJL0w0hgGFnrIUlvbhv029gxC83hupY7hbRfvi3Sybs5KgtM5xg7ZYQ8AN8txQmjPUyypu52RZc46Ty0lVICwBX0mkywqqOad5IdyyGkyEDJF1UarbXIoeZGYRYumHAA6AY8VU1yEdU6rx9/sFDJMD7iZLqrQT9XrQ6leLh9ruUrrOQsd9WTaaefHRgdS2iCRFRAr+C0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vubLWmtWqKeMlK47t8WEhMdr0Batk3JO8VBBrBVeOfU=;
 b=Pq5/zeb7cFzOe89VIKXGCNAxqNY7ilWnwwhqB43uHYxpx15EGnp+GON3Se4HPKTGAfJVoZjh4HbTMwmDcoo5f3NnEUqlWUxj0hLQnWIoQ6JOEEi09OIlE+foW9D0rrrH/XFTsbNUTrJcqI0+oL5X2F+o9LvzTSXArLSXgqjG4kI=
Received: from BYAPR21MB1352.namprd21.prod.outlook.com (20.179.60.214) by
 BYAPR21MB1352.namprd21.prod.outlook.com (20.179.60.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.6; Fri, 21 Jun 2019 23:24:51 +0000
Received: from BYAPR21MB1352.namprd21.prod.outlook.com
 ([fe80::b52f:faf3:6bc6:32de]) by BYAPR21MB1352.namprd21.prod.outlook.com
 ([fe80::b52f:faf3:6bc6:32de%5]) with mapi id 15.20.2032.005; Fri, 21 Jun 2019
 23:24:51 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
CC:     "Lili Deng (Wicresoft North America Ltd)" <v-lide@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: RE: [PATCH] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Thread-Topic: [PATCH] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Thread-Index: AdUoYqahDsLeDiTlTqKiO6h8RAkcdgAJUV9w
Date:   Fri, 21 Jun 2019 23:24:51 +0000
Message-ID: <BYAPR21MB13524CDAAD1F9A19935E5F9BD7E70@BYAPR21MB1352.namprd21.prod.outlook.com>
References: <PU1P153MB01691036654142C7972F3ACDBFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01691036654142C7972F3ACDBFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-21T19:02:22.0981116Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f5ac9eff-e920-4812-8c36-4a93f3cf745c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8bcb456-7a95-4c70-3087-08d6f69fa8f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR21MB1352;
x-ms-traffictypediagnostic: BYAPR21MB1352:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1352C9E82C4D26EFB8A209FDD7E70@BYAPR21MB1352.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(136003)(366004)(396003)(189003)(199004)(86362001)(7696005)(52536014)(6116002)(5660300002)(3846002)(76116006)(10290500003)(478600001)(316002)(7416002)(14444005)(81156014)(7736002)(2501003)(66446008)(256004)(71190400001)(110136005)(22452003)(66946007)(66556008)(64756008)(8990500004)(11346002)(81166006)(446003)(54906003)(73956011)(53936002)(71200400001)(2906002)(2201001)(10090500001)(66476007)(102836004)(99286004)(8676002)(8936002)(26005)(14454004)(33656002)(6246003)(25786009)(9686003)(55016002)(476003)(229853002)(4326008)(76176011)(6436002)(486006)(305945005)(74316002)(66066001)(68736007)(186003)(6506007)(1511001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1352;H:BYAPR21MB1352.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fOPOs+6npQ0yMuFMkxrEtHJ+9LIVMrUeRE5vy2oEWqsFP2G1Y+VywGcjE5pOW+XosnKCP28N6ibWe6PW3uvbeFgNT22mP8R8m4Crv2e8Xe3N4pxxlbXyx5aY6EgUvpRg30wG6X8sjbW4kVgFvkPAyRwKGrtQAUktEO1aPgGVJn0Z7l5cNy6dimlYj9zpZ7U/NaKVzPSzF0E84TFsHnJeEBf1w9qaPheZpeytbTtLPt9A33/xsRJ7d3Nr4QPBYHT4o340QP42O+vPw7xpPszKcJMZusS+/VAk7dsklfh3w1zMArp22NarGfNeEITQa+M5VLc8rrRgxsE+HqX/C0jpDS97pxJHT2lZUUtwO9f53hLbpA7K3SqJYZnjUVyaJVo1RbadUW2JvthR3z7CQv7YztmLMiMrqEQKwMDz+/ky8yY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bcb456-7a95-4c70-3087-08d6f69fa8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 23:24:51.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1352
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Friday, June 21, 2019 12:02 PM
>=20
> The commit 05f151a73ec2 itself is correct, but it exposes this
> use-after-free bug, which is caught by some memory debug options.
>=20
> Add the Fixes tag to indicate the dependency.
>=20
> Fixes: 05f151a73ec2 ("PCI: hv: Fix a memory leak in hv_eject_device_work(=
)")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> ---
> Sorry for not spotting the bug when sending 05f151a73ec2.
>=20
> Now I have enabled the mm debug options to help catch such mistakes in fu=
ture.
>=20
>  drivers/pci/controller/pci-hyperv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 808a182830e5..42ace1a690f9 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1880,6 +1880,7 @@ static void hv_pci_devices_present(struct hv_pcibus=
_device
> *hbus,
>  static void hv_eject_device_work(struct work_struct *work)
>  {
>  	struct pci_eject_response *ejct_pkt;
> +	struct hv_pcibus_device *hbus;
>  	struct hv_pci_dev *hpdev;
>  	struct pci_dev *pdev;
>  	unsigned long flags;
> @@ -1890,6 +1891,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	} ctxt;
>=20
>  	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
> +	hbus =3D hpdev->hbus;

In the lines of code following this new assignment, there are four uses of
hpdev->hbus besides the one at the bottom of the function that causes the
use-after-free error.  With 'hbus' now available as a local variable, it lo=
oks
rather strange to have those other places still using hpdev->hbus.  I'm thi=
nking
they should be shortened to just 'hbus' for consistency, even though such
changes aren't directly related to fixing the bug.

Michael

>=20
>  	WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);
>=20
> @@ -1929,7 +1931,9 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	/* For the two refs got in new_pcichild_device() */
>  	put_pcichild(hpdev);
>  	put_pcichild(hpdev);
> -	put_hvpcibus(hpdev->hbus);
> +	/* hpdev has been freed. Do not use it any more. */
> +
> +	put_hvpcibus(hbus);
>  }
>=20
>  /**
> --
> 2.17.1

