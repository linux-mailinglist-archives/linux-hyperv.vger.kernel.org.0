Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC679011F
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Aug 2019 14:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfHPMK2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Aug 2019 08:10:28 -0400
Received: from mail-eopbgr790128.outbound.protection.outlook.com ([40.107.79.128]:2403
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbfHPMK2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Aug 2019 08:10:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp+nJKa/HtU2+O9RaamkooPC07KyW7JyBITZL5i0eEJZ4XMjZKoZwBfqmytM8l0jkBLfNfPtB0cVACtllkBxY5XbBFVwkdQUJW04EUHGaIXB9QWRo3KPeWO1Fs8IpFusEU6XWZUKBYe6bcJ8Sgu226Tmf1NQJmRAr0p5rUfsfzQvuHs3j034scWlRPO7ZHjBfTYvjyDuYRsZF7uZYzbffW+gZV+gZWy5umOwaccWaS1E3S9/7i6p82hqjAFK5UqiI9m6rCfKjbX6aKuxMt7d54pWZqxzIfHNAO2DmuNXgX47m2/U1fG7lpDRqNj16RlDvUghSQDBOaxn0Nd8jE+utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkLzh6ohCU+Upn4/chf50IZRMev5DmD4TWoJX/sEqm0=;
 b=kNK2LPkHY6DCMo83hidDkBr+ADzWpnhwt7bUY5wXIHa/h7OU43TUE+za10nCclL97yl2EsApPFCM8cS7k/8pn0CuXLgg32uHmI2KRJUIvurzKao1UESuuoBD/m5d9KIVF95JMmoiQL14sRTR7f73KXZQuKCswa2/nfza0z2WwCBwm8wDycI8J7nRwsva17aNLgD9OBvlFAruZJkt6/f1A/n1GPG5P3DINNPVsMH8eN2YBJ9gOJKgLfv4gov4scXrfllMJTjwLFuTLY3AQzeQLKJ5lTnZs2lWCRmWOUq6I/qTx345kVBaLNF5S0+neX5Pbbpjj7UUCwY25nfVFLs/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkLzh6ohCU+Upn4/chf50IZRMev5DmD4TWoJX/sEqm0=;
 b=EpCH6wYjJb3bO1NyNcrvdTdoa2dqbmi3817QCa8mM+ZhX/7sODyTnjOIkNhGeMSbpJ4JdSjcBAqArfqGoyOJK8wJUiaUJeNXdxIo2XrsJ+1ZY1QAs/gyVGqmvcQ7zBEGbzZwzcB93Kp9nw9esu7oPAF/uTFGfUFHTnmN5QPhCxI=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1306.namprd21.prod.outlook.com (20.179.52.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.11; Fri, 16 Aug 2019 12:10:11 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::28a1:fa7:2ff:108b]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::28a1:fa7:2ff:108b%5]) with mapi id 15.20.2199.007; Fri, 16 Aug 2019
 12:10:11 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v6,1/2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVU4sZzIMW0sD7mkCdS1T3X/90YKb9iXIAgAAl90A=
Date:   Fri, 16 Aug 2019 12:10:11 +0000
Message-ID: <DM6PR21MB13371F6BCEF5FE4C2804B0FDCAAF0@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1565888460-38694-1-git-send-email-haiyangz@microsoft.com>
 <20190816095208.GA23677@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190816095208.GA23677@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-16T12:10:10.0116028Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4e876b5-5a3c-444c-8962-ef2bdeef118e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c0f7156-b776-46a7-e101-08d72242b05a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1306;
x-ms-traffictypediagnostic: DM6PR21MB1306:|DM6PR21MB1306:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1306EF132F02DEE9CDFB9BCFCAAF0@DM6PR21MB1306.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(43544003)(199004)(13464003)(189003)(33656002)(76116006)(6506007)(305945005)(6916009)(7696005)(10090500001)(76176011)(26005)(9686003)(316002)(55016002)(66946007)(54906003)(7736002)(53546011)(66476007)(22452003)(66556008)(64756008)(52536014)(102836004)(8676002)(66446008)(99286004)(74316002)(3846002)(14454004)(229853002)(6436002)(6116002)(476003)(2906002)(66066001)(446003)(10290500003)(11346002)(81166006)(8990500004)(478600001)(4326008)(81156014)(25786009)(256004)(5660300002)(186003)(6246003)(8936002)(86362001)(53936002)(71190400001)(71200400001)(14444005)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1306;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: axwHO+ltufopO9ioJ6aZI2AQY4XuQ0UJn+egXmLw9pclCJLPODfMU68hxLZ3N17q7ckVQABRUk7m+nffmsEakAIal+J4Stkwqd2IFXwW2VhHWBMDSooozqcnWswL1pHa0RYd8DstscDZN3Ud+UNVG4OceL1hHI83DfDFzN5fa1+PggMf/u7SxZVTS4CwqZE6wwVQwgmBx+EzZE+AdCIMDcH8jyXUZHGS+fsUO8DFT4EiMLfO2Kr2PsW20xs4/WJzu4734mxajuDN6mbZvdAihiAkOxFBcvj2SAH5SzVoNj51ksb6q28LhUcmUVVVPmeG/8RxaDcY5qPehZbJGoOOrjJ7LV5dUYhwgQFOwMu3LJXngt6MR795RmIhj2dYuaHnw8C3cYDenerax3sEwahbde57RfOx5IPil7FJCjV5nak=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0f7156-b776-46a7-e101-08d72242b05a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 12:10:11.7080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KguNFS2FknB19sckN/UkMDCQfoxBIAUzYv1XkBLWpue/GsXR3PYxMY3zDLAcDsXPaPp+GDFq4FOfOefB82SJsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1306
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, August 16, 2019 5:52 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: sashal@kernel.org; bhelgaas@google.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v6,1/2] PCI: hv: Detect and fix Hyper-V PCI domain
> number collision
>=20
> On Thu, Aug 15, 2019 at 05:01:37PM +0000, Haiyang Zhang wrote:
> > Currently in Azure cloud, for passthrough devices, the host sets the
> > device instance ID's bytes 8 - 15 to a value derived from the host
> > HWID, which is the same on all devices in a VM. So, the device
> > instance ID's bytes 8 and 9 provided by the host are no longer unique.
> > This affects all Azure hosts since July 2018, and can cause device
> > passthrough to VMs to fail because the bytes 8 and 9 are used as PCI
> > domain number. Collision of domain numbers will cause the second
> > device with the same domain number fail to load.
> >
> > In the cases of collision, we will detect and find another number that
> > is not in use.
> >
> > Suggested-by: Michael Kelley <mikelley@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Acked-by: Sasha Levin <sashal@kernel.org>
>=20
> I assume you will take care of backporting and sending this patch to stab=
le
> kernels given that you have not applied any tag with such request.
>=20
> I appreciate it may not be easy to define but a Fixes: tag would help.

Sure, I will add a Fixes tag, and Cc stable. Usually Sasha from our team wi=
ll
do the stable porting in batches.

Thanks,
- Haiyang
