Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DFF84FB4
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2019 17:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbfHGPVY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 7 Aug 2019 11:21:24 -0400
Received: from mail-eopbgr710104.outbound.protection.outlook.com ([40.107.71.104]:59779
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387777AbfHGPVY (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 7 Aug 2019 11:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTB4xavtR/weLDMs3QLNyuDgiwEvx6Rl+cxv5Leqkp+MEi1EbRvR3h0M7Zkr4/44wZrpOwqpHvtXQYy8D5amL/4b3WnUC/cAhnzNlItunggKiZjyiT8EXesOgkM5dV7KUEAxcF8oCbblfbwBVZJ6Kbg21n50a+Lu12xo5mEmjyv7MjL6rnTsqb17QZW5mOF7na4I5LYGmoyadGXzPzTlE74Z7mnosAalT0LM1D7eUtWuSgQ6+6RgxrdKwjLvCO19nHsi5y6gGFv1J4lY8h4zEhEeQMq0eLlrWzdWUwVbysVusPcdDakB4xpx6V+eqyZAqgq3z6Sk9BxHOSEJUq/mUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MaQK+f8dWYm9xBFbgOzTTbVliL1cMtL1b+C+4dLHFI=;
 b=kEIyztSfxgeyMMPt67bQoKH4Ktme4bSXyfE0yN9EjXHfWVTmap6ik8gK7nUWU7TL6AxMNg9XKjodGsAunLMkoXFNSEqPzEh/LqXYY9ovgo+5VGonMWPtXVwb6mcnnn/3BLini+U2+IePXcvXLBGzQ4rNW01LWqSZnkcaOqxIpjcc+iQE44eFwdB9Jn9EikeAUc4puTNuvhb2k09yc8LAuIBd8g7UXdbwy7uFErkQCwC1CrRHWB90iV90CXd9dM4JFItRJlDRlUd4B7wwByN7lvg1/tfUkg7NF4eqAf49nyfNlkTzv/UN0W1q8y1WoK+ZIbimyeAGbyVoBbS/VdRICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MaQK+f8dWYm9xBFbgOzTTbVliL1cMtL1b+C+4dLHFI=;
 b=mOrsuMvaUX6mHmOS+/6OLPWGf83RDdIOPJD7WrwZBp0RUCfhQAFEoq5EEPxR4ItVNiBo4vW+/N70iiiErR8lKqiWql6buANwV72vAwo3CFYpRG2hUdYj7zIUvs7PN87ZdqVhtnF4mgs3ZmTtSeD6ZqfNmLRi7wOfQFYwCHt9fVA=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0748.namprd21.prod.outlook.com (10.173.172.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Wed, 7 Aug 2019 15:21:21 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::9558:216:27ca:5dfd%2]) with mapi id 15.20.2157.011; Wed, 7 Aug 2019
 15:21:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/7] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Topic: [PATCH v2 4/7] Drivers: hv: vmbus: Suspend/resume the synic for
 hibernation
Thread-Index: AQHVR8iqvnQQXjyXzkC6LH6XcTu46Kbv16rA
Date:   Wed, 7 Aug 2019 15:21:21 +0000
Message-ID: <DM5PR21MB0137C86DA324FF19E88244A1D7D40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1564595464-56520-1-git-send-email-decui@microsoft.com>
 <1564595464-56520-5-git-send-email-decui@microsoft.com>
In-Reply-To: <1564595464-56520-5-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-07T15:21:20.0503360Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0430ccc9-edd6-49e9-a828-d94e6a59fe56;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:2e16:ac86:48d:60c1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12584926-ed95-4ce3-9a24-08d71b4ae738
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0748;
x-ms-traffictypediagnostic: DM5PR21MB0748:|DM5PR21MB0748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB0748D276AC5FF4F694FF77C0D7D40@DM5PR21MB0748.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(6506007)(66946007)(7696005)(14444005)(186003)(229853002)(102836004)(76176011)(476003)(4326008)(86362001)(10090500001)(25786009)(10290500003)(6246003)(478600001)(446003)(2201001)(7736002)(22452003)(64756008)(6116002)(66446008)(110136005)(33656002)(46003)(8936002)(55016002)(74316002)(53936002)(4744005)(5660300002)(71190400001)(1511001)(68736007)(316002)(305945005)(9686003)(11346002)(76116006)(66476007)(14454004)(2501003)(66556008)(2906002)(71200400001)(486006)(256004)(81156014)(81166006)(8676002)(6436002)(99286004)(8990500004)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0748;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zeZNNgPOJD6izp1akwQ6VVLoND/urywUyzCQzaAJ1D33TfwGMAoSZsr+lnxNLww+QsnAsALCMkMgJ48pOx547X+fUVg0eoca6mFhCwgUqMn9UZ139CKeOYyc58CbF/17JpJ6KxClXmR+x178d9oExeEblvfGmOxAthIKTI1F2bdLTU3YHzVvYSDo/rLezGr/BD7XRy75UXyjs7INJ4w0wpNkOS0NCQAnTW8NrYf7/mrYBcm8JBq/hOftdNg/DrNYKCMLxRljvBWVAB5dz+JGNlbHsTltMOljuahTxNmpDEv635PTl7YIrVXRHaCwXeq7pxaUuE2H9ecv4DRB4J6eeA2mMKOHHQV5bLgEAu7Exwzbyzhgyq1WQYYitx5a19v2f8UQUn1E1PF2jMBKTf9V5h1rmZYBYDNbs7RmOwfv7LQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12584926-ed95-4ce3-9a24-08d71b4ae738
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 15:21:21.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpDPxO1fOxA8rZ+EyW4HK/YeCV5Xj4VYYa5E10GmyuvrzkVbkdh5x+p4xz3fC2icKAIrDq4TnfNviKfCgqDff/D5PF4dKD/I6LY1ZSa1rIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0748
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Wednesday, July 31, 2019 10:52=
 AM
>=20
> This is needed when we resume the old kernel from the "current" kernel.
>=20
> Note: when hv_synic_suspend() and hv_synic_resume() run, all the
> non-boot CPUs have been offlined, and interrupts are disabled on CPU0.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 46 ++++++++++++++++++++++++++++++++++++++++++++=
++
>  1 file changed, 46 insertions(+)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
