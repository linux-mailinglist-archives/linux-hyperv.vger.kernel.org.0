Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1595D3C8949
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhGNRHd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jul 2021 13:07:33 -0400
Received: from mail-dm6nam12on2117.outbound.protection.outlook.com ([40.107.243.117]:28480
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229729AbhGNRHd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jul 2021 13:07:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDbxiEH8qcLLjQz93FNUhbC9jwWt6YEChb9Rdmd4am36/KJ0auzT4jW0ESJW5BssHiEh48puUfYs+3AoiBXBfrpfV99Xp5lqLhWd/evf5rhMonr1ucsC4iUR3WASSSvk9cjLmlJD3k43WTK1efxyYNepxpwg2GVSgedYiZI/z/FYF1LO2D37BvaKy0nPkWKb3A3wdqQ2FcN+yzLxZ65I6751vCo831vBoJ5pgCoiME1GLZsbr69wqYltreawy1CWnNH2/1UNeKUIsdTxReO5aDfN7tFhLYh/8aDa7xFBUHTJb4ysHSd5B/K8rf70ACzoKXQ1Udqkpr4cmpXDymkc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xafmQBP45ixQic/B/P3ieZaH7CEqVbSyLyRvOXGpsZ4=;
 b=XQWBvM8G3eCTXBOFerl3BXnwpyM9/hGRt8LxRwyDzaKNdNEic0Sduh88t0mEzR17G6CuScH9cUTZsEL2zEf5T53cG16yF6Nm6HwmxFvRBAunzsgMg4x3lE6sm+ngPPDkW+pnBwvLyqsi39eLZtAxUxz2wCtndWzLg7ACSYGaeWtlz9P4+WSjxNyM6Xil63AZt6if/7iepnPXvYJZAdIOAURGN2MVXemPrUW1yGKRkL7zMhtSVPzQGkD6xfiXTIVxM97rU9ZHkQG8DeYNmo1MBi5yp4soeLNo/4Z4EDl/R+Fn45urZ5vGyNesg99ZhgOTdKAb0jnLTGxSf+Mv1eWxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xafmQBP45ixQic/B/P3ieZaH7CEqVbSyLyRvOXGpsZ4=;
 b=MjhNFj+pkbkJnNPbcBFNVZoCKDoV0LLsXrGB3cIp3pP11pIzqtBwe05MmjfueFGQhD8Ddb23RK0N77TLvxoN+UZNvOWEjFIYUdZZONEV5B8vnlJBChC759kbTDtB30Mcxm4sZ+vuUsXo/s8FU+GbXbKIeh8i2ty+1ah1Wlwr9A0=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MW4PR21MB2042.namprd21.prod.outlook.com (2603:10b6:303:11d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8; Wed, 14 Jul
 2021 17:04:39 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::6082:4114:68ee:f569]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::6082:4114:68ee:f569%5]) with mapi id 15.20.4352.007; Wed, 14 Jul 2021
 17:04:39 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: RE: [EXTERNAL] [RFC v4 5/7] PCI: hv: Use pci_host_bridge::domain_nr
 for PCI domain
Thread-Topic: [EXTERNAL] [RFC v4 5/7] PCI: hv: Use pci_host_bridge::domain_nr
 for PCI domain
Thread-Index: AQHXeJsnz4dHbFw/f06lwHDi2IcMJqtCsQQg
Date:   Wed, 14 Jul 2021 17:04:38 +0000
Message-ID: <MW4PR21MB2002D9659313C9B642171629C0139@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <20210714102737.198432-1-boqun.feng@gmail.com>
 <20210714102737.198432-6-boqun.feng@gmail.com>
In-Reply-To: <20210714102737.198432-6-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2acd74a-cd94-4717-c47e-08d946e97752
x-ms-traffictypediagnostic: MW4PR21MB2042:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB20421C023876F156680FD7FCC0139@MW4PR21MB2042.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TIAjhoNeYSx4/Pumgw3+OW2nlUBjmXAZhjXT914nnoKeJQX8mEmy42R89D1QdtWnLHKefhNi3jhk6N1yXZHvtmc990StQx5kOm1pOlzIMclDvJxPu05y4P4FCU2sP0/7gMpdKH3twwfNh/apKuhgf0SYBpBerAjPDLAUUiNrBTLx9sFG2dFD+8osrHGYly4WgUVbPh83J0emhxLbs/hy8vx2m0d2MLWEilxlwsg9qf/EUWWuTi++qF0d5mY9TKyCuFyEVnDFSs57gQXZkr00Co30sHTp7d71aC/z+Weer3KYrlITh5QbZbEzM1I48VVbBLBfw+OTSOX7t6BT1mo7WhnBqvBdC68asjb+uRdTI9Y3f0Yqt7p979K+GixZoDLIzq9WN8WsXjOqqSfUBGftx8/DV64Nrxz5LKnzflmpeZQa25p1jRGdmYcYqIRRIXlD8SJalhu+8JShqL7HHh7NbifLXLgcRKhpQz0gleOJz5/Nfod4OOAvwYXx+VwvDmmtrtBXseEhdFE9DP4bN81BLFmDjLjI+Gy3ioZd3CSvD5N1P85wNwRCIFDPj15dGadqomEubcVxMK/7iO7HRX6rbuu/Dut4Fyk1zsczKBSFxq71+nOxzE3cJDAkguhXFh0IkweiAjSNRO+82zRsrlCAcCdU3PV1MaE1BdSTqunLtS96XTXzfAweI5p/66C0O2g7rVhDyJF+yuoT3OLky52Lnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(8676002)(10290500003)(5660300002)(54906003)(8990500004)(82950400001)(4326008)(122000001)(83380400001)(110136005)(316002)(186003)(76116006)(82960400001)(9686003)(2906002)(86362001)(52536014)(478600001)(7416002)(7696005)(55016002)(33656002)(38100700002)(66556008)(66946007)(66446008)(4744005)(8936002)(6506007)(66476007)(64756008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?EjJan/hpiCHbNzb6YeQikijWeGgMdJ9FkQ5KJTnHE+mePDs9WFATsCaOmH?=
 =?iso-8859-2?Q?OY2bWD0FvMmKVuIqQimk7JUC00KQecmEqG8xsl5pyTjR+ICTNIypNXzmpb?=
 =?iso-8859-2?Q?h2goN+EgGgihLZ7Oyvpn4WoRFd4zOQcpVRaIVtp0dT7xnF9SpPs7JqnTa8?=
 =?iso-8859-2?Q?Eehinqug7mS5qkKmsqQNH2rmA9Cmm9YCyBxoVv4PT4D8bQAEZ/inmuvkPE?=
 =?iso-8859-2?Q?JuTjhtpDDpXBm7eu3PbCjHt4AU1QZcNqtLUY90kSkNXBExoXYgJ00FbGum?=
 =?iso-8859-2?Q?8uXB29xtLVK3mn/32xrqKpHRj9wLxZSeztE2/6Do7ETdzgllNLtWei+osq?=
 =?iso-8859-2?Q?0RmGkvNWZFm6MEAoTc1H6Bg39ueKnfrCIj5XHgAXfrA+T6u54xOt9UlJOM?=
 =?iso-8859-2?Q?j0SzrN5o2KXwRyDrm3AdbuFrru+f0Fna3ZgofbLuJY2sKeRmSXfvZTOvVc?=
 =?iso-8859-2?Q?DVATiJ1JDNlHiUI476J86D7aqDjqEvSsELmxc3SJ1Kv1ShYoToI0+cg1hR?=
 =?iso-8859-2?Q?NICGCX1P6NdcBEmzS8e68IuK1K+wVfG/qMyHz5SOIXeBxI5zrK+cTvdP+V?=
 =?iso-8859-2?Q?nwcQeLKeFZSNHy5G0tGRgKkbMiQVNwMQgQGPvOG+7jroCpWznRm8N1eEdE?=
 =?iso-8859-2?Q?NhpWSROoqefypvOVJTDPwuCFwlO1/hSKt0QB3wQhVSAPQkQOu2NcHZJ9Kg?=
 =?iso-8859-2?Q?3a1DMYb9nfIArHI7Tl57DGFSqkiKW4OD8AjxUt8xDZPCHZdac0Tw5rrgjR?=
 =?iso-8859-2?Q?Rob/NeAi3xKLrg5CA4M59Zqc40RU2oxJfluG/VXkum+boz1V2TXuR9XCVb?=
 =?iso-8859-2?Q?5KJ/v5ZNXS//pwu1P4NyfiTUQmmwStr0zqQs1I7mACTgToy+IYAI5D7Kdl?=
 =?iso-8859-2?Q?wGGseb8YofLPbAgBph/dU1xyYS75JWwg6iNmAi8Sod90bqsGJzVnGI/yMn?=
 =?iso-8859-2?Q?GaeCBMO+wqtQuy5adIVIi4NTv5iPqaVoX4SH6TdS35cFqQY0X2F9+WJa1E?=
 =?iso-8859-2?Q?nfWwsNvE7dXM7IQjmTk34MEv7E9ceYxYyBiiZLg/XwC740ljV/mi9xkY/v?=
 =?iso-8859-2?Q?Bzll7nm22R8XC5uMbeMajJ3CHKFpGlPEgtuchqUbnbmPGrzIhAYg/A4Z8F?=
 =?iso-8859-2?Q?ph8Ker3Zz5FUuGhrqhDun2xA5UH+NUgCDklDEqSCxt9QXqgDaDbIkxzVMx?=
 =?iso-8859-2?Q?rbAj2Qs/KBZHStIZaoX4yUuXqEEFdwmuOpUmaZmCqrK0KSWTw0STxor6iz?=
 =?iso-8859-2?Q?CrylDOugNhkilKqMmSHvQ99AVS0aMMMvnr82KIzqJmC9UjRsybH3yPDZ5F?=
 =?iso-8859-2?Q?rs/q+DruYXpZbfYLZ4Ogw96a/bGK4UJ8mQeZvu6R73UYp4gnqP1fmziSjI?=
 =?iso-8859-2?Q?mE8ryqJLJpUu5no7xxC3J/Be9bui+3D1GSchxqPqhdPTlQhroBRuRzgK7w?=
 =?iso-8859-2?Q?FCiSXqRFsrhg3DAU?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2acd74a-cd94-4717-c47e-08d946e97752
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 17:04:39.0075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNnrE+IsNNeZntCqxZO225mln7mmQLE4gBXh3R48WEToewb12elt3SzdRaXBI0BunkNdErDRztLRhsU7romYa7T2M91iwEYUCeYYsXsqVeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2042
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 8d42da5dd1d4..5741b1dd3c14 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2299,7 +2299,7 @@ static void hv_eject_device_work(struct work_struct=
 *work)
>  	 * because hbus->bridge->bus may not exist yet.
>  	 */
>  	wslot =3D wslot_to_devfn(hpdev->desc.win_slot.slot);
> -	pdev =3D pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
> +	pdev =3D pci_get_domain_bus_and_slot(hbus->bridge->domain_nr, 0, wslot)=
;
>  	if (pdev) {
>  		pci_lock_rescan_remove();
>  		pci_stop_and_remove_bus_device(pdev);
> @@ -3071,6 +3071,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  			 "PCI dom# 0x%hx has collision, using 0x%hx",
>  			 dom_req, dom);
>=20
> +	hbus->bridge->domain_nr =3D dom;
>  	hbus->sysdata.domain =3D dom;
With your other patches everything is moving over to based off of bridge->d=
omain_nr.
Do we still need to update sysdata.domain?

