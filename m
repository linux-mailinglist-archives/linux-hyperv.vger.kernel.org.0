Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18A5139C55
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2020 23:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgAMWV0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 17:21:26 -0500
Received: from mail-eopbgr1310110.outbound.protection.outlook.com ([40.107.131.110]:20928
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728746AbgAMWVZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 17:21:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWvKdXhQS+gCrPgGJU4cSF4T9MJVfUnY6iqJUbIvuFwf6XMTYsm3jMuzkmuT54zyHwQho4ON3FtYX7L8BF6ecjALUWVN0xKzP3614uSSFp6pMz7OPHpveUNjB+FlOLf8LMhYjZqYu+aiCunxVEtLXPBIJR77q+vaYQYH+H3MGIYWEQuzPcu/Bf9ba/cNNIUX97mXe/kNtm3cM25tyaHE7W81eqYPklmI/4aWTjb9w0rI4GkUmbiMwxXUuN48HxigFqL869yLO7+f2V8EE4RPX8Ef1RVIZmKwVcsnNx4W72nQoi78sJNsQtzYAe35DRMqUjkgND/baN2mGDxLfx15/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWHOMA1VK28NQcDd1c9ecAJ8Lq9KeO3QYZFvjPy0go4=;
 b=OGvtva27UBxbMvpIaMbzxuNqJq2S8lapdfUjtobitw+OAzZCvq7Jpiap9pbuleVDkvp+qK8Kgpi4TiknFr1a17n+5y6rrFYcr30c16jZ0oTQwS/MM4TWrlc3cWbrIyex1yvAE1zb2BLe7+jlVrlgTKqSI3of/nqyl+2pMCwggERDjGikZZKmwCwOaQgqXrbRyPccamF3YDdjArvgEu0jBmzlx+rQ18U83nmMKtt3JkfuhqVOZ3mViopYZuOPxCR703+wMdA7S6YKWkwp+TLQxVmrfpHxcg0WmT+ADcwjHb77JYymLuhNDmNK0/uxjXKVeVqOAs4m7SUweX3KJ8E8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWHOMA1VK28NQcDd1c9ecAJ8Lq9KeO3QYZFvjPy0go4=;
 b=R7cLjYaRDQvNk+ZhGugaYywlCis5ILBsukfxWg657TuxiLq+QWjakMi8rIum5vD3ZcbrqOHCSNLYIzdu8/eIhmcpvvRc4hlrOOjP/QigQpkJZulvn8za9NSZeu8EX8Zn537ud+ZkvOXZf18L2H0p1xQ7xm0p4aaJNUyPxf3uAPU=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0322.APCP153.PROD.OUTLOOK.COM (52.132.237.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.5; Mon, 13 Jan 2020 22:21:19 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::15e7:8155:31bc:d4e7%7]) with mapi id 15.20.2644.014; Mon, 13 Jan 2020
 22:21:18 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/4] hv_utils: Add the support of hibernation
Thread-Topic: [PATCH v2 0/4] hv_utils: Add the support of hibernation
Thread-Index: AdXJ2sJyDrPgyG+3TJyc2gafIqgsoAAg4Ifw
Date:   Mon, 13 Jan 2020 22:21:18 +0000
Message-ID: <HK0P153MB0148F30D914976A906B35427BF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB0148968D9EFBFAE1E881674CBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB0148968D9EFBFAE1E881674CBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:29:11.3769804Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7131548d-9dec-47e9-bdec-19b34d517361;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:192a:f6df:afac:5af7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e5e02f0-804b-42e2-9681-08d79876e97e
x-ms-traffictypediagnostic: HK0P153MB0322:|HK0P153MB0322:|HK0P153MB0322:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0322AE79B4D6A7F50936F775BF350@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(86362001)(8936002)(316002)(110136005)(71200400001)(966005)(8676002)(7696005)(6506007)(478600001)(81166006)(10290500003)(81156014)(5660300002)(66946007)(52536014)(66476007)(2940100002)(33656002)(64756008)(55016002)(66446008)(76116006)(66556008)(9686003)(186003)(8990500004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0322;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BoS7NAGV7WmGwKzuv6rcxikcMuqJVUJD07XuOsEIesTzTLYsm0dJWq5FlMaeKtuALYdBexk28OXqSbat2eKZRpZla4uLnNhJTv2rmUHQpyKtsOZiAJS5lBJzxvgjd57V2nr4OoXBTx8+d1TYVLK9F1e9uR6t0IKvgbAKavJOJerH16O9qLjxYD3U4++nFfIbYZE+RGhKWNPdeoTtjlkzPii1eIJBWBc8ZcxEeZoseL89IlZJ31XRysI1F3Dp9ZX7F9roRc8EcabuaBu2OkBdu34vGG3EHRgHaHW5B/fSPQ4KrjdzS2LYUWrc2sHmMSKJfyUqQZEXvoQIR0ffpg2gSNP5UUEoI/F6GYdO6sw7e/qV9dCACcBMU06sleYOgNs6hK+Mz561iYi7QgEBw9oDyE0BgwdsDoeKJZNBw894RboBwUlcxSytuJVcwXCVRlwt3aEWfs8zJxjcsrYRJAnAbFTnrjGI/pBh0x7S5UImgppvdtLDeNfvL3YDOKCZjqfCOdJ0WgG6x9VfaLgh+3BeVw==
x-ms-exchange-antispam-messagedata: 426NDlxabvohD2ujTkC4SHQqnJQUcVw4S+6Gq3/5lUqDHeNxH89CVpR513x4F/qNToQ5CcWKfT3H2Jd2dlnIpS7eo7un1BQ1iPRze9MGImT3LmKXcCQGrLiBnZad8F+dU/9trl/rn75hH5/IMp6bWQJlhmwaj/nCsFa0CMhvU/kd5zXB41i5VSf/Qu298NmV+1R/V0U7pU+uNbGANMOlYw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5e02f0-804b-42e2-9681-08d79876e97e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 22:21:18.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxCbsPbyUS6eDb5AfMFprtuWwl4YGZTlDZaGbTJA2CFIdckd8oWhHRp5NjGajUb3d5C6scVeE6o3mU9pySIvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0322
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui
> Sent: Sunday, January 12, 2020 10:29 PM
>=20
> Hi,
> This is an updated version of the v1 patchset:
> https://lkml.org/lkml/2019/9/11/861
>=20
> Patch #1 is a new patch that makes the daemons more robust.
>=20
> Patch #2 is the same as v1.
>=20
> Patch #3 sends the host-initiated hibernation request to the user space v=
ia
> udev.
> (v1 used call_usermodehelper() and "/sbin/hyperv-hibernate".)
>=20
> Patch #4 handles fcopy/vss specially to avoid possible inconsistent state=
s.
>=20
> Please review.
>=20
> Thanks!
>=20
> Dexuan Cui (4):
>   Patch #1: Tools: hv: Reopen the devices if read() or write() returns er=
rors
>   Patch #2: hv_utils: Support host-initiated restart request
>   Patch #3: hv_utils: Support host-initiated hibernation request
>   Patch #4: hv_utils: Add the support of hibernation

Hi Vitaly,
I forgot to mention this for patch #4: IMO we don't need to add a new
HVUTIL_SUSPENDED state to the hvutil state machine, because:

When we reach util_suspend(), all the userspace processes have been
frozen: see kernel/power/hibernate.c: hibernate() -> freeze_processes() ->
try_to_freeze_tasks(true) -> freeze_task() -> fake_signal_wake_up(). When
try_to_freeze_tasks(true) returns 0, all the user-space processes must be=20
frozen in do_signal() -> get_signal() -> try_to_freeze() -> ... -> __refrig=
erator().

hibernate () -> hibernation_snapshot () -> dpm_suspend() -> ... ->=20
util_suspend() only runs after hibernate() -> freeze_processes(), so I'm
pretty sure we have no race condition with the user space daemon.

util_suspend() -> srv->util_pre_suspend() disables the tasklet and cancels =
any
pening work items, so there is no race in the kernel space, either.

Thanks,
-- Dexuan
