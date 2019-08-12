Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551DA8A011
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Aug 2019 15:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfHLNui (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Aug 2019 09:50:38 -0400
Received: from mail-eopbgr710137.outbound.protection.outlook.com ([40.107.71.137]:63312
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbfHLNui (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Aug 2019 09:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZwGpaqW3SgBGnRpnqQASy5kn1L6yj/aL0RtCopPBiFH6KaMADLNgUyMXXzGokNcPbT1rDNtgaaZ+NSABgXp19TlMM8ZGxgFe6Rvo2jXYL290j6+m/D37y86CDH5Jx3PqqwGy/Urt3cQQvlvbZ44cKZlONWl41k0+c/zuTTlurLcCVA+DePy54ENo6sehNkLZ8Cba+hvFXCv9rjBX8sX8Tf0OFOCcsemaTEuNThaEhMvBCH7lxVeXrgu3kB1aVSL363ghOEyh95uUO7M56zkiBtELeP1iPwtCwIS74vCE/jgXxefyemGYNd0A4DegzXf0o5zrGfQZJybc/1ybZJ6kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKwUl+iop+1fNOpIzXHF6+hYJuY8PEvgxiYMLDEmtsM=;
 b=gP/MXZ4YmmDIKotmkqSP5ZfK5bWHnNerOpcWsFSjklW95264gQNHvKurpeFufglABIwQMCDjRTHLBGs6Wc045YPs3h8f6EtOwohXRbxN0DqIfFikFrT1XWV6wR/zpomak+Boq3xigCqpgcbtVuPDkf/EVUouHK3ztHNyyCwxuSC3OiLTAiWBMgxezh9W4+DLbDz4myw21RmnQezvy3jHYb/xmJYfQ1UKdGvjC/nN5CwKZmqzRoFIZU2Jszu+P19uDguayIjmMyE46i1PaZKY0YIdcrqQRJayEajR8jxKEnC0bfnkoVicEQji/jbKLZRyRVn37JzOKr2fISqQj88P+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKwUl+iop+1fNOpIzXHF6+hYJuY8PEvgxiYMLDEmtsM=;
 b=Iyrstbs2tF47TLljC5nVUnaqBI1JnceYTxVi81xjHklqW8QivXyvUJbf53InibFl3/n+eCtjnaQC8m8H5ZajDkDLnz9lFdYDE9WFMpqGsWwUsrBM+XymG0HrvMMj/AWX3KpsxBgHucE47PyJthFlyLH1ZNQ+MpzJMSswu6Wvvds=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1419.namprd21.prod.outlook.com (10.255.109.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.4; Mon, 12 Aug 2019 13:50:35 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::257a:6f7f:1126:a61d%6]) with mapi id 15.20.2178.006; Mon, 12 Aug 2019
 13:50:35 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Topic: [PATCH v2] PCI: hv: Detect and fix Hyper-V PCI domain number
 collision
Thread-Index: AQHVTLH3GagQ2bG1NUyV/+P043l1Z6b3j4iA
Date:   Mon, 12 Aug 2019 13:50:34 +0000
Message-ID: <DM6PR21MB13379DCB3007D728204A0D8CCAD30@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <1565135484-31351-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1565135484-31351-1-git-send-email-haiyangz@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-12T13:50:33.2405330Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0327dcd0-4e67-4d5d-98c4-e691d1eeb84b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e308908a-44fa-499b-fe00-08d71f2c0cce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR21MB1419;
x-ms-traffictypediagnostic: DM6PR21MB1419:|DM6PR21MB1419:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM6PR21MB1419A06A6327F53B67CB1DF0CAD30@DM6PR21MB1419.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(199004)(189003)(13464003)(33656002)(2501003)(8676002)(9686003)(99286004)(7736002)(25786009)(256004)(26005)(2201001)(66446008)(6506007)(66476007)(66946007)(229853002)(53546011)(64756008)(66556008)(86362001)(55016002)(478600001)(53936002)(102836004)(446003)(11346002)(6246003)(305945005)(476003)(76116006)(6116002)(186003)(3846002)(14454004)(486006)(8990500004)(74316002)(316002)(7696005)(2906002)(8936002)(76176011)(10290500003)(22452003)(6436002)(110136005)(10090500001)(52536014)(54906003)(66066001)(81156014)(81166006)(14444005)(5660300002)(4326008)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1419;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +7LK/9RweCkxRgOgeGWeGZ0W8BQZJHJ1j2KfRDlHsxkrdfWAiPNPOg1ySWU0yrAKsumeLuXcUwD9oSFxIolmEEpq9uR7c72fC7AdN0QHfNuQ1sCe3r/CPLQJQsJlzMlVA0P+4ybz2fyH03svuAX77KDodUguwf4msX2CM9J0lAhwqa47H/6QG08/0eBWQC/NvkI0mvLru6QLMqkoLrQ92Nj2gxSWQ0COymRCutT4PREsxSCsMCaLeg1jwf2Gx/wXdE4ptJxDYWjC/K4dzsfdvFach39um3HG4i29bzicV2aKWEt5Dbr2GJ4rzRYpSuJu4g73Cs1qlv0R0555pAMV/DAhG5Pw4GeKjqCwL/Nt4hNsZmr84YUxowh//vmp5LTjKTrHvuAmpX2miXCV2e1Ni05ximfAk6KDTsyXVBC/mcQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e308908a-44fa-499b-fe00-08d71f2c0cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 13:50:34.8027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1Xo4KBgVIcO9uCsgX+g+YeBFhxabdv/0Ykw1pfqs9d010S9pXRjmiusfmoCy8o7fhkCxLblXCnYYnu5pE7Nmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1419
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: LKML haiyangz <lkmlhyz@microsoft.com> On Behalf Of Haiyang
> Zhang
> Sent: Tuesday, August 6, 2019 7:52 PM
> To: sashal@kernel.org; bhelgaas@google.com; lorenzo.pieralisi@arm.com;
> linux-hyperv@vger.kernel.org; linux-pci@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v2] PCI: hv: Detect and fix Hyper-V PCI domain number
> collision
>=20
> Currently in Azure cloud, for passthrough devices including GPU, the
> host sets the device instance ID's bytes 8 - 15 to a value derived from
> the host HWID, which is the same on all devices in a VM. So, the device
> instance ID's bytes 8 and 9 provided by the host are no longer unique.
>=20
> This can cause device passthrough to VMs to fail because the bytes 8 and
> 9 is used as PCI domain number. So, as recommended by Azure host team,
> we now use the bytes 4 and 5 which usually contain unique numbers as PCI
> domain. The chance of collision is greatly reduced. In the rare cases of
> collision, we will detect and find another number that is not in use.
>=20
> Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this idea=
.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Acked-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 92

Hi Lorenzo,

This patch has been updated based on Bjorn's comments. Do you have any furt=
her
comments? Could you take it from your tree?

Thanks,
- Haiyang
