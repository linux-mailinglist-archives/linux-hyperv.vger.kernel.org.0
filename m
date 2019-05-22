Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3325D71
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 May 2019 07:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEVFOt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 May 2019 01:14:49 -0400
Received: from mail-eopbgr1310099.outbound.protection.outlook.com ([40.107.131.99]:42551
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfEVFOs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 May 2019 01:14:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=VQZDCwOhSUHVrQ2Z995q6pDwWa/qSKFq+qKRVzYH5Ow21XQ6tbje9/hXdBPB1tFGPE+k5NFjPiySntUjBA8x8+1ymJ9uFSXNFA62yXCFxgsrZNfeZADFeVc2WgwJrVlmlxZBPUmI0FCVEQur4f8hOh2kiPWcDmP6vJ57fGfXG2k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y19JCdPuf9uVF9qJHJG3kC9ZS6Ar0waTtB8sdWI1csw=;
 b=QnYv8oW6274aAPdBFji5KdBsklmMtTfe0MpS/SIBMahUU1dt6PhKTgKzl893Zdopl7Lg/3045hsf4dnmSElPoORd1j7URmSzRgH7cNYgBB4JOeo1hftc7ewPYhub/68xQX1sHvPxGwpp+IsBsq6vZm8VBTpMt5JOzxw/b99q5Cw=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y19JCdPuf9uVF9qJHJG3kC9ZS6Ar0waTtB8sdWI1csw=;
 b=Qm3+equ60hMaeSqBxOxkJrEPVFK28Mkkqay+Oo04cBrbQDDFd8b3trFaz1uZfGLdHiav6/7QbgfLkBaizgtYUBrWMAfQ7sVFAIpjKoSRTn+pq8UIOTNzRQ+hbI2RzOJevuuTUvQy0jonbOE7ZXcVVeV5H/mRpZ+QnUXIM3+IHaA=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0121.APCP153.PROD.OUTLOOK.COM (10.170.188.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.3; Wed, 22 May 2019 05:14:40 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d896:4219:e493:b04%3]) with mapi id 15.20.1943.007; Wed, 22 May 2019
 05:14:40 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVDpIz+mZnowKmCU+oYiS1gYdC2KZ2e2rggAAYLv+AAAJVYA==
Date:   Wed, 22 May 2019 05:14:39 +0000
Message-ID: <PU1P153MB0169CF7AC335C98C971582BCBF000@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1558304821-36038-1-git-send-email-haiyangz@microsoft.com>,<PU1P153MB01690809D82F85EDE4BC5B9CBF000@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <BYAPR21MB131778CC3A356745BC74EE3DCC000@BYAPR21MB1317.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB131778CC3A356745BC74EE3DCC000@BYAPR21MB1317.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-22T05:14:36.4421488Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e158bc6-a282-488b-bb04-130ffa25db8c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:e0e1:6836:3789:8439]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c8f5c1d-1736-4cdf-b2d5-08d6de74645f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0121;
x-ms-traffictypediagnostic: PU1P153MB0121:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0121FB91C542045AD87D2BB2BF000@PU1P153MB0121.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(366004)(376002)(396003)(54534003)(199004)(189003)(40224003)(2501003)(68736007)(66446008)(73956011)(66476007)(66556008)(64756008)(66946007)(33656002)(229853002)(6436002)(4744005)(14454004)(966005)(10290500003)(8990500004)(316002)(74316002)(25786009)(76116006)(22452003)(52536014)(6506007)(102836004)(7696005)(9686003)(76176011)(86612001)(486006)(446003)(11346002)(476003)(86362001)(2201001)(110136005)(54906003)(55016002)(46003)(186003)(10090500001)(6306002)(256004)(71190400001)(71200400001)(99286004)(1511001)(2906002)(5660300002)(478600001)(6246003)(8676002)(8936002)(305945005)(7736002)(53936002)(4326008)(14444005)(81156014)(81166006)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0121;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9YhFQ0Sv/zaOWNnZbtmiW50mUb5R00zc98Hc49NrzPejINxxtd7HGO3c/q1QN+dVod5fvsWK63UBLIfbZz/FHra42+1xeGNvjhIaehnGbMQ1JLHjL4p3nS1aRkv6i3/DVsO0BUokdpB3M62hyvR/gdnU9nAejQnVfIgtrBtUSNsLQBC9/0CevLBgLFELdEK0AFGAlCKimgUub5ABeN5EYMylXSoJ0IrflP6PKl1XGOMJ+1NnVXBz9SpqSoZJjIa4lYjTdj12wLnl4qd4rbnuXoCh31Kq5TjtoD5aoMReV5gfNLOb4dPaNDjCdtg8qrG7AS0TUCtZ+mfz5J8Lp0WMmvHJQJb4HKFPU4zXYROCdl5D8LZbwC+LibrPPKFJm9QFD2LBPRzdXyBHdE6Y7R5Il1nSODgwdYzdZXeCesC/SJ0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8f5c1d-1736-4cdf-b2d5-08d6de74645f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 05:14:39.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0121
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Stephen Hemminger <sthemmin@microsoft.com>=20
> Sent: Tuesday, May 21, 2019 9:40 PM
>
> Thanks for working this out with the host team.
> Now if we could just get some persistent slot information it would make u=
dev in systemd happy.

The slot info comes from the serial number "hpdev->desc.ser", which may not=
 guarantee
uniqueness: "...Hyper-V doesn't provide unique serial numbers": see the cha=
ngelog of the below
commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D29927dfb7f69bcf2ae7fd1cda10997e646a5189c

And we can pass through multiple devices to a VM in any order (i.e. hot add=
/remove), so IMO
the "slot" info is not unique and persistent.

Thanks,
-- Dexuan
