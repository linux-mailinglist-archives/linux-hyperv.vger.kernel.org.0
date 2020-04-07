Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD441A1355
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2020 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDGSKx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Apr 2020 14:10:53 -0400
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:22688
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbgDGSKx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Apr 2020 14:10:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhIh4ScezEEy8nMQ/JmrkUhqeZyUEUNFlLoyO3EybGupPkNfH1x2BAdrN0szI7WRTT0n4PDXmtT1S6u4VX/gGMXJpTdqGFx7+6GS+sc80l2dNMrR8MWsQKav1SMnm5C426imN1GTAeJb3FPWTEuWbIkJgQCj70nqydNLU5fp3ltItC0ltWkEo1vdp5/QKmm/8oxsdFqeXPvH0xcqtMm3DH3x8bf3spBr/sC2xdUB1BYQ+HGdwzK1PSocEjFGlj+TaZy0UBEWD1+m8QMRPD1fooyoMy8dZOHSX45Qk9EOC503UcomB0dJsylI2uz9fxdDeuo6Un32l1FniaB1sCDEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=955toTs1i4Rp1kxZe76x/GdBR1MHgdUT2ujwGJ4yGAo=;
 b=Xiy8xx4slFM14EcDkbXXC5l5R5zK5+7CTP05/472z7zT3a/XxdEBgXZecXpGx18p5mdVx1KkojYzSKT8CeJSYzyjNg5cC0plZOsTRuSU2Ys/9LnGkSAWoKqYhRavvYxDoh3x4fX89YpfLFlMiFtJ7IpVXJPNTPDOKZEuKKBxce30LuYIvScPucfda+RKCzKTYEmd5t9Cl9CbVwTNZo/F7VMKCVYDYhAW2Y6qawIwQbEYzOb2hf9YYZh+t47n2KTCHyjUiBjPsFTcXt9H2hulCEeG8A9Yum3wnzQ1Re3uOETWrQ6rjsEmqcMNDv8a/Uxwi0VBhocz4Z3t7yjd6ZrkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=955toTs1i4Rp1kxZe76x/GdBR1MHgdUT2ujwGJ4yGAo=;
 b=fLA7cwtbmc/GFTrVZfRgxvY61SBX7Bysujn+TkgLTj4SqUAwNFekfZieGDv9ZCCRdheAa/N/VDxicsfi2KqPPtwnedRD3cdZLtH8T+Faj7ntgm2B6163YYE7RDzhXi38Hn4S0VTx5TCga22GMugQ0hJr3m104wBwHBXkpojYPLA=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) by
 HK0P153MB0177.APCP153.PROD.OUTLOOK.COM (52.133.210.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.6; Tue, 7 Apr 2020 18:10:43 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2921.009; Tue, 7 Apr 2020
 18:10:43 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, Christoph Hellwig <hch@lst.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: hv_hypercall_pg page permissios
Thread-Topic: hv_hypercall_pg page permissios
Thread-Index: AQHWDK4fRmHhn5txXkSoYvQO1Kc9Eaht9OJw
Date:   Tue, 7 Apr 2020 18:10:42 +0000
Message-ID: <HK0P153MB0273278D61381693E022B3ADBFC30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <20200407065500.GA28490@lst.de>
 <87v9mblpq6.fsf@vitty.brq.redhat.com>
In-Reply-To: <87v9mblpq6.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-07T18:10:40.4233602Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=13eeedbf-bb62-4239-aed0-70ed63aeaf09;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:38fc:d3a4:dc68:bfc5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3c2fe18-2ddb-4ba0-c21a-08d7db1efca9
x-ms-traffictypediagnostic: HK0P153MB0177:|HK0P153MB0177:|HK0P153MB0177:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB017735F5127CAA14D567C2D1BFC30@HK0P153MB0177.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(76116006)(81166006)(81156014)(8676002)(8936002)(52536014)(5660300002)(8990500004)(82960400001)(82950400001)(316002)(54906003)(110136005)(7696005)(66446008)(64756008)(186003)(10290500003)(66556008)(66946007)(7116003)(66476007)(4326008)(6506007)(9686003)(2906002)(71200400001)(86362001)(55016002)(478600001)(33656002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J/UOSM1x5O1FSChmFrkb/WAW7RN03z2tKhqmpYJKWBtFEvavkKdMRJpEeWpWFWAD6TalQttUluLoNtyyTeH53SJcoWNG0O8w25Ffd3//yE4wUVei2G+m/TPLBwDlMlD76GzH8UEe4l9xdcxjR5OqsraU8Ce9WxnZEmCnUreCK86GDx9XqJ/czU2wlwj+KIJOE1bHmr3M/KR004+dNamnvyMNEzeXSv0OnLXNEdMluFeKTYQM/Xyb6wHuSHiByoRmOfmGm7rdTjOHwQ048WV0vmFmMAGSdgs3ixu6c5xq7ziIggWqLeIrY1PsQzBHzyE7nDO7vIWX54TNaZ78+3vx7dXUqgCiykp7voDHRA0EAKobgQ++rLscBYx0prJVBIUwPebQnIX6GjoxPpXFfE9DifKYyAHlgwK9qKiDeWgr8oCtgzFgaXIzOP9hFKdOqG13
x-ms-exchange-antispam-messagedata: 990udObKCS01YNKbOodNcA608BVgCMDfetzgSSeFOBrmSMR9V8xiMeIzW3goQ5vnkgyR/rUwwbwlmMqrkw7IFfYGGI3bvICLEsYExpEh5q3cJMor0XDeVUxeY9u6xfmn0PZ2ch77Hsyjuc1A+gjZYoDjrzn/srv2wDYWKO4gKcKMnDN6UZtjdpwkP09DThvFTD1BdOAVH+z+Ooz0h39e3w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c2fe18-2ddb-4ba0-c21a-08d7db1efca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 18:10:42.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fiFM60CYymm3RL/GerXuU5zV90bz9ouAY/s+ucr6JnCt7t9W/M+x/tvzxu+VvFb98oC4Dnx2N5F9DqtDMefwyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0177
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Vitaly Kuznetsov
> Sent: Tuesday, April 7, 2020 12:28 AM
> Christoph Hellwig <hch@lst.de> writes:
>=20
> > Hi all,
> >
> > The x86 Hyper-V hypercall page (hv_hypercall_pg) is the only allocation
> > in the kernel using __vmalloc with exectutable persmissions, and the
> > only user of PAGE_KERNEL_RX.  Is there any good reason it needs to
> > be readable?  Otherwise we could use vmalloc_exec and kill off
> > PAGE_KERNEL_RX.  Note that before 372b1e91343e6 ("drivers: hv: Turn
> off
> > write permission on the hypercall page") it was even mapped writable..
>=20
> [There is nothing secret in the hypercall page, by reading it you can
> figure out if you're running on Intel or AMD (VMCALL/VMMCALL) but it's
> likely not the only possible way :-)]
>=20
> I see no reason for hv_hypercall_pg to remain readable. I just
> smoke-tested
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 7581cab74acb..17845db67fe2 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -382,7 +382,7 @@ void __init hyperv_init(void)
>         guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
>         wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
>=20
> -       hv_hypercall_pg  =3D __vmalloc(PAGE_SIZE, GFP_KERNEL,
> PAGE_KERNEL_RX);
> +       hv_hypercall_pg  =3D vmalloc_exec(PAGE_SIZE);

If we try to write into the page, Hyper-V will kill the guest immediately
by a virtual double-fault (or triple fault?), IIRC.

> on a Hyper-V 2016 guest and nothing broke, feel free to go ahead and
> kill PAGE_KERNEL_RX.
> --
> Vitaly

This should be OK. Just remember never try to write into the page, unless
you're trying to use this as a means of forcing a guest reboot. :-)

Thanks,
-- Dexuan
