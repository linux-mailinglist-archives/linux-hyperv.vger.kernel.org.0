Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B8DBE5F1
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2019 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfIYT6Z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Sep 2019 15:58:25 -0400
Received: from mail-eopbgr1310119.outbound.protection.outlook.com ([40.107.131.119]:22016
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731558AbfIYT6Z (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Sep 2019 15:58:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNjCoqV8xB1CtmJ61JoFSRWXZHwzDl4u+iSvi75K5Dr1O+MRPoosqwSEQQ1DBtBEq4IkPKvou6zS0QHV2zUVUMrMXlYRx7j72+7vxeRwOsaTszqCFDKneElr3M2nF61aKrcxJL5KjGYdue1+dwGUOixAgKJ0ZkODxcnqv/ew2BU54ZVnWnFLZwoWC/D3MVvKn909OWTjpz+uan6WTgMWgm7ah5t9dfuTBLH8shGp1gZryHVYITbVIYWVWl2RqhqhvLZzF3rucIkbKEbF2PRxjlQ0TWUb2Fkfy074jT3GHG9YFNhsXEYMPK8xTMzlrnptENuUsnU1WVnhrWhUUECRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruImq6z2u7l/I9wGOdT5yc8ciXNcjkVsC6mAHYZJZ84=;
 b=gGx/fcWmKzxLb2KJ6Md31uYxdbpAMNKbVy2jzrVcf2eoPU+QseVENoiOuMdfV0hVajTYnIJOaMQmkozhoFl5mpzhCbrcXYpF2Hu1FeNeDVKcluKjUiR7pw2IdLlLmGjX+mNpT5GEjq21MWD09H4VO17HvSkDxOX9JjvQ94Jxl6idsnRAC9jK+PjXMk3qwnmuKfFNOSNrt6x2yzBuQbDP54jamM4/Ls31EJxc4OHa5XEdR+Jiu2s2S9LcU1KCb3i9Zt1BZtHUsQcG3UU3gA95zg8Bam6K7n83Od5nIr9OyHjd2RJ+xsr7fALtJF7/qAaC+aRQA1HEY+KWQLg9hqRfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruImq6z2u7l/I9wGOdT5yc8ciXNcjkVsC6mAHYZJZ84=;
 b=gH2B7MRbMO2LaAEk9LfM05Ua6/2ySonUTQ6iFOghBd1WB3efaxlH8n7h/hEV00+vOOd4X7FgG8gj/lfj1bUZnBtr2FbsDIIDyIhB3Py5vmtzFCoynmKz6QPkFciLzKV7rH2B99roooB7UtxtM+ashsBZFQpy4hL8MN1R2Sr4UfA=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0139.APCP153.PROD.OUTLOOK.COM (10.170.188.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.5; Wed, 25 Sep 2019 19:58:16 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 19:58:16 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 0/4] Enhance pci-hyperv to support hibernation
Thread-Topic: [PATCH 0/4] Enhance pci-hyperv to support hibernation
Thread-Index: AQHVaPn8vIIXMuXG2k+dW/CDPjDTsqc85Daw
Date:   Wed, 25 Sep 2019 19:58:16 +0000
Message-ID: <PU1P153MB0169DF37D4A5BCCD1BBDFA16BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245086-70601-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1568245086-70601-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-25T19:58:14.6162445Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d9180726-6cb6-4fc6-be35-b7465a97f3f2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:35f9:636:b84a:df21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb65bb0a-db0e-4468-6aaf-08d741f2b4cb
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0139:|PU1P153MB0139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0139D83239C4042E9D27A333BF870@PU1P153MB0139.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(189003)(66446008)(66476007)(66556008)(81166006)(64756008)(10090500001)(71190400001)(71200400001)(186003)(6436002)(6506007)(53546011)(110136005)(46003)(2501003)(7736002)(81156014)(14454004)(8676002)(229853002)(498600001)(446003)(10290500003)(11346002)(22452003)(8936002)(2201001)(25786009)(5660300002)(476003)(486006)(33656002)(9686003)(55016002)(6636002)(102836004)(7696005)(2906002)(76176011)(86362001)(99286004)(74316002)(6246003)(305945005)(6116002)(66946007)(256004)(14444005)(1511001)(76116006)(8990500004)(52536014)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0139;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4zJKT6tr37GIrSaThJLxow0p7HCHR56B/RLOj3uQjd4yaGzhq6f6n+C5739MNhB7DyFUvRCBLgohhGCHo0QFnmTJ1eTZ3GnK7ymZXswQFikfPC9ErriJNxfIfn5wfYyqqjdG+TmFUrTWdwT13Lcx0oNgKydxr44h6nWP8VhiUP0Vhf3xucZukr7bhefLVevPvsnZjTtS5ra+tfE7dlJM5S92P8LLihf2O62472/N5uWRhBg/dwKUsGIDKBuHSacortol0cXP+7FRnoBtmvWT5R0WgysbTzDlDLAEW1eB9YYpbJXwZEy0ZncXaaCJulgSPw+Pj8lZ9KQDrPPIOoxrh7qGY6/ixXc8n4K/OctnBHwVGIF6jzc+zwZuRqVre03W3us/TXOimCyrOIFrBdLoRd/x1g7AN1zDBG1lJCMIrD4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb65bb0a-db0e-4468-6aaf-08d741f2b4cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:58:16.2978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAo7Y9lO4gcB30o+9IucCPr8vZMsDVXdIqy1UDcT3vVOfeRr4ADAckyTKbuK8p6vYebscfGZN8P9wppPPOeqSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0139
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, September 11, 2019 4:38 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; sashal@kernel.org; lorenzo.pieralisi@arm.com;
> bhelgaas@google.com; linux-hyperv@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Kelley
> <mikelley@microsoft.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Subject: [PATCH 0/4] Enhance pci-hyperv to support hibernation
>=20
> This patchset is basically a pure Hyper-V specific change and it has a
> build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus:
> Implement
> suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin=
's
> Hyper-V tree's hyperv-next branch: [... snipped ...]
>=20
> I request this patch should go through Sasha's tree rather than the
> pci tree.
>=20
> Dexuan Cui (4):
>   PCI: hv: Reorganize the code in preparation of hibernation
>   PCI: hv: Add the support of hibernation
>   PCI: hv: Do not queue new work items on hibernation
>   PCI: hv: Change pci_protocol_version to per-hbus
>=20
>  drivers/pci/controller/pci-hyperv.c | 166
> ++++++++++++++++++++++++++++++------
>  1 file changed, 140 insertions(+), 26 deletions(-)

Hi Lorenzo, Bjorn, and all,

Can you please take a look at the patchset (4 patches in total)?

Thanks,
-- Dexuan

