Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A002030FA5D
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 18:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbhBDRy5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 12:54:57 -0500
Received: from mail-mw2nam10on2103.outbound.protection.outlook.com ([40.107.94.103]:12609
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238201AbhBDRys (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 12:54:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzkTqxjUGoR5kW1t64coOS5sOmoX5ToSYa6uRLcdQcn/5JeKd7IFwQph66g2RTkoCWhgjlZxsb0QYLnUEnZ1F+kxvaHwaJfzXMOTRmeSVRawTTN71baG8KPxJKgzzw3+ISDNlga64YJrc7Rlh+mws7qje02OpSeDpVdA2ZW0Csn8PojG+sGUA5FOyq+Z1XvRjyneJcDoR9hoRJ40ISyNn9UYAGK+/9iMtDAWBRsyHKjE8MXOG0YHO0bt7KvFDhKbQPHK+iQrDNcoDuYOQYfXhsIzEPulmC/SbpMGriJLyGt4NhEcD1e4gzCIohFp47/Qv/kkksiKqMAJrxzvbPi16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a15breN6v7/6RZ8assTbzjyUpkox5g6VCUQvJu3rxI=;
 b=Xfb8fi7XM4sk9PdswCAzVYQr2D/CwphQ8TajTGJQRvoCeAcWyIby6rqIBQDo8W8F/fk+Out6Jl/EHTBqKe0/LOEdLWRbbHnaCGm4Cc0/OP5xvgcJFhfP6c0e/oxaIU7SdxPSNkh6+YBCX0pSEENo9GRDW1xVpqcPXM+ERuf0qgz4QMGEi6J0NGrsv+Cgf3UlZZvkmJ3MBcqIWEQG5+UkE5CQ9h0sTcSOyLUYSaPLiFjCljuaFTD6Fel6Gc8fNBQhfsKNNvEJYm2cwzez5GjNuuT/Ni7CZ8W1Zd3KYxE2SH1SxI/olFXPS9zMlgJsqgmbBFbiJcW/UyelkpbIlhzhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a15breN6v7/6RZ8assTbzjyUpkox5g6VCUQvJu3rxI=;
 b=HAIv6KsykTy+BBqf7BWzhkOCa5jHRLFnehMCcQ+pXbDZsh5bb+BZ1hF4vk5aohgIFsTDL8oUF2/fyTy4mkdcqnOosx5LiCSG/IaYHAGSwK0koFhXB66Sr3e7eW518zxSx6sQpI+vZhpGnmIhU9iO9jLOPceoPIlTcFj/KHfjnXk=
Received: from (2603:10b6:301:7c::11) by
 MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Thu, 4 Feb
 2021 17:53:55 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 17:53:55 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v6 16/16] iommu/hyperv: setup an IO-APIC IRQ remapping
 domain for root partition
Thread-Topic: [PATCH v6 16/16] iommu/hyperv: setup an IO-APIC IRQ remapping
 domain for root partition
Thread-Index: AQHW+j31sX8XTKaHaEW+K0rkDWqrRapISLLw
Date:   Thu, 4 Feb 2021 17:53:55 +0000
Message-ID: <MWHPR21MB159329D4EA13215C208D7828D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-17-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-17-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T17:53:53Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ef2c78a6-f632-4744-a1c1-679068bd2287;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 949aa3eb-507f-490e-508e-08d8c935d74c
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB087360720F5F0F8A1F0C540AD7B39@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eguCWD75ZeKlC1x8rCdqJn75BSg1oU9+ceoFGDP5Ju7lTd38Si02+u46gaQRz2ie551/P6t2rbBAN4KjWv73mXLYQCavJeWRD6+H5ODmvaovjhL56LPFCQTELuNlwJIsvgBxJKz/wupM3uDkJogXaLF7nzafJTZj/MR+QB6QNz5ov2R98Fy8FJ2UOmas1ARKuw11Ft3ec42WMbr5MNrvNUtUURRB6lHbmSdfPpqkh35NBQ5dOMxkKhmiOqPZtZxbpJ5LUwcKCYD/fmi3WUSjNode3ycf/793pFWG3ghDaPRjCVVdIi8l+gQPRbqcmnmEWX9om9mGlr+krD2bsD3CjjH2HdpdgxFG1dtGlUo9BOFjFRqzJvf81lz0f8joD59eRvgE6C2mX9Y2NNSpNzosAzCBI2Bbzvwwq8lfE5tfz9qFZwPETHJhylW8HTx+LsLtA2URJNeswke3TyCApsfFdYe1Pov9a6l8CVwXccqCex9dTeOJYtOvwFIGEtBIsKJcMiwOGBS7UwY1ttkWXvaVBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(6506007)(8676002)(33656002)(66556008)(26005)(82950400001)(8990500004)(66476007)(82960400001)(186003)(86362001)(2906002)(7696005)(10290500003)(4744005)(316002)(66446008)(76116006)(4326008)(110136005)(478600001)(55016002)(52536014)(7416002)(71200400001)(8936002)(64756008)(83380400001)(54906003)(66946007)(9686003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: z1FZG/qVdzvPmsdw0RBb+ElltqpJLNjstJNUsWY9cDuDrHPdgecDMmvQzWwbRHmjh8gTSEVzP7jOZ55k4DH/uQiucvw+Q1fD1bfnEX80ofuCli8cZcOTyaYVLp65MXaKBdRfS/R2Y9l5phQtAPoGtLIMSWHAAQT0VXOOX2TiGoAoALKJd/LsXJ4JLLXslVfV3gIOnpKNSDnsFim2jFMZGjLd5dupqNPssgjn9mlzn1Go1zWc1g3jpXkpblMYpoFAtB3OzBiz1VaipZTBxQJdrYdkXEEJFTJmvGPwgB+EAAL6+xDp6q2D+Glph1y9e0LQVk+0BX+bBhUnqUizT+Dtb43b7YCqaN3RnEk1l8d9+nie2sk02JSgjCSEqPhfPN1JmM8LcF/MhEZJu3uqECpzRdOliinX9lpA7qPNshb63orlcXNXVGN3RZCPlEBZeU4AiRFs1PzgsDsXoatfZcRfoB47Sc9ucRktctxlSbJzdVC+/Z556VI7vmRThRGmq9g+/zMASW1+Ro7HgMLle6w13ymKQOkRFsDVlLqfMuHdWoJDUOlTK6fgfh6RyEN9DXZm5ztYnH2rgUmLebGAgRyEUejB9HKWTzmHfhcbCC80kUFApzT6qE3MpjVcFtwmLy5nH3rE7on7AoW/LQb/OLkiwrp10d7knbFU59xlPcs5GAF8qzSBPId4P5kVSVaIjBSUTLAJks0mugwReKv1X3cWgTpoIT9bwc7KRTqg9MrYGVc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949aa3eb-507f-490e-508e-08d8c935d74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 17:53:55.3368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WyxcVU5EQHqyF1Nzke/qbyUVZXNeLMmsPIkHC849qCzSS4GCVlIpHf6jYD9Ja6Fq995VazWiXmci5Ovx/ho3AY3ExV3rS1FYJN5JbFe4mkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 7:05 A=
M
>=20
> Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
> Hypervisor when Linux runs as the root partition. Implement an IRQ
> domain to handle mapping and unmapping of IO-APIC interrupts.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v6:
> 1. Simplify code due to changes in a previous patch.
> ---
>  arch/x86/hyperv/irqdomain.c     |  25 +++++
>  arch/x86/include/asm/mshyperv.h |   4 +
>  drivers/iommu/hyperv-iommu.c    | 177 +++++++++++++++++++++++++++++++-
>  3 files changed, 203 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
