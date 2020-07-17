Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3EF8223D50
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jul 2020 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgGQNyL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Jul 2020 09:54:11 -0400
Received: from mail-eopbgr680091.outbound.protection.outlook.com ([40.107.68.91]:17634
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgGQNyK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Jul 2020 09:54:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzBn2y/YyZ0bFVeKs1g59/2ZbKy4NrRmL1bmNzqPtHmgngdxTUfAjc3l/pVavnuv5CmIgOQ0McyVdfefwBqFuLhl8lPXEMvQrVJ6GJ7L5Vhj0I02rtOgtbqY9whixf+ddYB9cLSNGB69L53t/W/XIXFD0AZOi8Ms0TSyYRW6jVv4Cuudp7XkfaDbLaGHjtMSk5EZCvb5FiPeEGi8uv9tJ2BxJWs6qKQl0Q35xf1JY1L0gXCLn2aY3c09Rdj35yw+z9pO7euVLkqPQTAapRf9JLjgHEvoyfBNNVMbMEzqAKW1hf1p6J1l1pL/EWLID0vpU6VxXq77Ix1snDCjqo2HMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU5AExu0ZkmPYAw5FHsGFdZsAh0SMgiPwXXjd/jpkT8=;
 b=Mkwgi8jrY5bG2f56zs7n2TLeFnohGBWScgBRzhMzN2OaAWMLEBtMFTxspN+vcWXUi3c35ff54i1skYbuIQs5UtJRta02Mr5Z4Smw4if2Ie3QCR0pjZB1avTw3HlT8Kpflv01oKiumNwoVY9hDqSJSFyudAMxpKcJClGH7N4UBav3U1EG22ONU6FLU8limreauENyqT4yyZxkiPvVKh+zNFgQji/P4Ae0qAvfRl8JpbW056PixODhsUJxWmp67uya05irLHSDZ1nBNR8OpKJD9OTNokTD5LMKXpu1pAEe6hgkpRB0DQAbn2dzNJkAnvp3CAeDIcziV7xIzlSL4UQdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU5AExu0ZkmPYAw5FHsGFdZsAh0SMgiPwXXjd/jpkT8=;
 b=RGLNU9z0TonymMuLZzmXm9Kg10lTXgCTYY84CluM6SaKv+PRg285yIcKeok9Mh2Rn3ExaUXoDCor7YXaNPQgYTFFAMljFg3sgm8b0eJT3cMRJB9Y34VjZuM+jtccjto0eyZ94ad/8Q5jeLwcupf0qiWr3+FcNdXY80cMhhMymW8=
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com (2603:10b6:805:6::17)
 by SN6PR2101MB0989.namprd21.prod.outlook.com (2603:10b6:805:4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.13; Fri, 17 Jul
 2020 13:54:07 +0000
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::bdd6:9c11:7d18:5855]) by SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::bdd6:9c11:7d18:5855%5]) with mapi id 15.20.3195.018; Fri, 17 Jul 2020
 13:54:07 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
CC:     Andres Beltran <t-mabelt@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Andres Beltran <lkmlabelt@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH v4 2/3] scsi: storvsc: Use vmbus_requestor to generate
 transaction IDs for VMBus hardening
Thread-Topic: [PATCH v4 2/3] scsi: storvsc: Use vmbus_requestor to generate
 transaction IDs for VMBus hardening
Thread-Index: AQHWTzxT58klv4yPs0iqRD3vnA4qZaj801cAgACgZoCAAAEmAIAOO4oAgAAzdSA=
Date:   Fri, 17 Jul 2020 13:54:07 +0000
Message-ID: <SN6PR2101MB1056F67B43877AC7298D2748D77C0@SN6PR2101MB1056.namprd21.prod.outlook.com>
References: <20200701001221.2540-1-lkmlabelt@gmail.com>
 <20200701001221.2540-3-lkmlabelt@gmail.com>
 <20200707234700.GA218@Ryzen-9-3900X.localdomain>
 <20200708092105.7af7sf2olpaysh33@liuwe-devbox-debian-v2>
 <20200708092512.muse7szgxyihazvv@liuwe-devbox-debian-v2>
 <20200717104556.ul5s6hmtlerjpi3g@liuwe-devbox-debian-v2>
In-Reply-To: <20200717104556.ul5s6hmtlerjpi3g@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-17T13:54:05Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d7dafab7-3fe9-41cb-81f0-36be1a49e843;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af5e8991-89e6-47af-ff04-08d82a58dfee
x-ms-traffictypediagnostic: SN6PR2101MB0989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB09895DC7C4DC8C6E91306575D77C0@SN6PR2101MB0989.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LBVGokE/q7JXmOyZrht6NtarwwA8L8Wwnv7lPHm4LFptIA9ZKXnibhTdeCzxdKIa1sUcRyhOr+fcMmL/fGZVtpyCPibkczcCARosHNuNN0EPXNcAMVc4LWG130b8XG7c+Rxv5lfHtDynueCFaDH1Qf6zAVvxyj9v5/Q+6P5VND73eKH5zAN0+GJ2Oz4rq5Gw6qEIQnrEqpP3PVLAKh47LknrnihKEel1kej5ZvEWFd81SSk+xCJNRW6hnBcWF3pGhNeyY5AuFhL1EZPY+OqMHpbVtE1okBEaH2wzpyTAjECfifiYpTlMy7qN6n6w0aDAWFRUSLwHk59+crpJ6VpfSY9pYbHNVW+fdJjSO8Ibh7FxUhZ7Ra/KQQkxGkRa0Q/mBoY53ORGvUlAd5D5c3sHww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1056.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(76116006)(8936002)(33656002)(83080400001)(7696005)(9686003)(82950400001)(82960400001)(186003)(5660300002)(71200400001)(10290500003)(54906003)(26005)(8676002)(478600001)(110136005)(8990500004)(86362001)(316002)(66946007)(52536014)(6506007)(55016002)(66446008)(2906002)(966005)(66556008)(83380400001)(66476007)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vvHNdYu1sM4eJgTEOlOo2jkKn1JHIgdF4Eo7dMuu7a0dtgIo7GTpRGR4ft4ouTd3TW8kg1yTMsI9BW2iJOg5dg7cB5TK6XLqG14Kkn+AH0pz8PLgLuYX3Ekmyb0ytS0hcR9p/u6vjO98jcooyFjiifSWrxVlv5IXL9urZnqAJv5GvxmdBAeezmWDvSvmEU5PO/TwgqUh2AnCskqtEuE+xzFM+fmGfQd827HDTI7FyPfqFDw1gVsFd2qJupuXQyrmKolQd3HXIWZGLFnFpuXQyVYZ1NRqEgNILYm9O9bRhGV36vA1Dmjgx/n0AJ+ae7par6E+ds+RPhj4Xcu99/fu6P9aFRinbzpq8vIdHwvvfSVGk7Hulg9nuKsNmplHGl+Br5UMgjZT3Uhu5S/UdggbqxxkX9ErTBh7vuT+M1mlJFUIgNXkQpLmDv3zyH1hQOlkMbw8oHoi1ng2X4ETFA2mciGn1DDnXURN4VVcXQ0f+avzG1lGxEFwgPWscPV38hnp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1056.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5e8991-89e6-47af-ff04-08d82a58dfee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 13:54:07.4246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dt4xGKMb8tEPZEc9JYSI2QcVMxA1aEKmtEmy6+L6FFnxFWrzvyakW+OPwvEVl+KdEsSelTJh3zXAj15bCjgo+vUXRA2Zsh648P9YxjiZiwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0989
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org>  Sent: Friday, July 17, 2020 3:46 AM
> On Wed, Jul 08, 2020 at 09:25:12AM +0000, Wei Liu wrote:
> > On Wed, Jul 08, 2020 at 09:21:05AM +0000, Wei Liu wrote:
> > [...]
> > > > If I revert this commit, everything works fine:
> > > >
> > > > PS C:\Users\natec> wsl --shutdown
> > > > PS C:\Users\natec> wsl -d ubuntu -- /bin/bash
> > > > nathan@Ryzen-9-3900X:/mnt/c/Users/natec$ cat /proc/version
> > > > Linux version 5.8.0-rc4-next-20200707-microsoft-standard+ (nathan@R=
yzen-9-3900X)
> (gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.3=
4) #1 SMP Tue Jul
> 7 16:35:06 MST 2020
> > > > nathan@Ryzen-9-3900X:/mnt/c/Users/natec$ git -C ~/src/linux-next lo=
 -2
> > > > 0ff017dff922 (HEAD -> master) Revert "scsi: storvsc: Use vmbus_requ=
estor to
> generate transaction IDs for VMBus hardening"
> > > > 5b2a702f85b3 (tag: next-20200707, origin/master, origin/HEAD) Add l=
inux-next specific
> files for 20200707
> > > > nathan@Ryzen-9-3900X:/mnt/c/Users/natec$
> > > >
> > > > The kernel was built using the following commands:
> > > >
> > > > $ mkdir -p out/x86_64
> > > >
> > > > $ curl -LSso out/x86_64/.config
> https://raw.githubusercontent.com/microsoft/WSL2-Linux-Kernel/linux-msft-=
wsl-4.19.y/Microsoft/config-wsl
> > > >
> > > > $ scripts/config --file out/x86_64/.config -d RAID6_PQ_BENCHMARK -e
> NET_9P_VIRTIO
> > > >
> > > > $ make -skj"$(nproc)" O=3Dout/x86_64 olddefconfig bzImage
> > > >
> > > > I don't really know how to get more information than this as WSL se=
ems
> > > > rather opaque but I am happy to provide any information.
> > >
> > > Linux kernel uses Hyper-V's crash reporting facility to spit out
> > > information when it dies. It is said that you can see that informatio=
n
> > > in the "Event Viewer" program.
> > >
> > > (I've never tried this though -- not using WSL2)
> > >
> >
> > If this doesn't work, another idea is to install a traditional VM on
> > Hyper-V and replace the kernel with your own.
> >
> > With such setup, you should be able to add an emulated serial port to
> > the VM and grab more information.
>=20
> Hi Nathan, do you need more help on this?
>=20
> MSFT is also working on reproducing this internally.
>=20
> We're ~2 weeks away from the next merge window so it would be good if we
> can get to the bottom of this as quickly as possible.
>=20

On the Microsoft side we now have a repro of the problem when running
in WSLv2.  The symptoms match exactly what Nathan has reported.  We
will debug it from here.  Thanks for reporting this!

Michael
