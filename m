Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED90E1095CC
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2019 23:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfKYWtN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 17:49:13 -0500
Received: from mail-eopbgr730139.outbound.protection.outlook.com ([40.107.73.139]:19484
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfKYWtN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 17:49:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4hUzbTFSragkAKeywOSHRit6EWbJXF0eoiw3MBWvGrAjhl6USts/sFhUIOggiqbKAUxhOKuIcmvdXtby1HotVJGmMlHXE2yWTzq/b3AZQXl3UvyJbTJ6tyNYUIxrhCcFGNIInRvzTz5TxYDZyzRMtFeeMibbEMuYlLaIwBaCV/FHNrDAlmSTkpRU7+/J0OFUo8BgivyjyCQxdH093PxImeH4Hb5DpfiOL9P+mRHZA93rr5dl8ic6TYTCoXmvLCUMaTEOAUv27x9l1PbrjdNPvuWPjHAb0tmnQXdkcPmciJS/LHRut8WARwHe9t48LD/fjgqEpLbr3LQS6jhPCKGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOnAL31v/OdG1AkgbLe9PHBNmFlqrBlhYWuYpi575D4=;
 b=dV09e1mys+ClgQcml+53htFeD2JKbHpQ1UmhMIB6h1AGKaTCmt2pDelWk1qRvoXBvfFz2HpWlxXI1k7CADqagPnXkhWq4bTdhx17bzPL1G9nL7huGIjAEipxdkujnXpeUBFhdpok6WkJc4676k/Ud1MKnrG2EFiYgPAjbqmKsRm3hJy0niUd8TO43YvCWEs65opJIiihCGeCYQSSMk9diKb5VQNjWI6LrPSBZvtEtzpAp2xTx02b6F+aEHaKZ0L7/3/f5NklLF+Z7TiPD4jikFp7eRgLgoWwefv5Dg2Bw1Erh1Wybof5RXlkdmySYAJkVXuKt1Zqh0Mu4XE6rbz/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOnAL31v/OdG1AkgbLe9PHBNmFlqrBlhYWuYpi575D4=;
 b=M745Ye6gGwywAh4G/A2VSR2K7sbDNxsApKEZhDlOIsPdB691QUcEbwVqRd/UrJIJZC/h05YHy3e4g4PHQjd/e/UjBQnkOFqN0oS7hmiWgCpqbgP+PTfPTzqUbGtd6h84uZzgucpoNg7OHGeVfTaO1E5d5zcBnIRVMs1ZAowgf3w=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.8; Mon, 25 Nov 2019 22:49:08 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.003; Mon, 25 Nov 2019
 22:49:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
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
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v3 2/4] PCI: hv: Add the support of hibernation
Thread-Topic: [PATCH v3 2/4] PCI: hv: Add the support of hibernation
Thread-Index: AQHVo1H2bol+NsRMTUaaEVqe++3Nr6ecfkfw
Date:   Mon, 25 Nov 2019 22:49:08 +0000
Message-ID: <CY4PR21MB0629EB2E3335A2AC69BDA27DD74A0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1574660034-98780-1-git-send-email-decui@microsoft.com>
 <1574660034-98780-3-git-send-email-decui@microsoft.com>
In-Reply-To: <1574660034-98780-3-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-25T22:49:06.1050107Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b66eec47-b4fa-43de-891d-4431441ee47e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:cc71:9380:de71:b696]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d16209e3-1fdd-4189-6188-08d771f9ae8d
x-ms-traffictypediagnostic: CY4PR21MB0469:|CY4PR21MB0469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0469CB5DA32D10856B4728F2D74A0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(376002)(346002)(189003)(199004)(14454004)(33656002)(46003)(305945005)(52536014)(66946007)(76116006)(64756008)(6506007)(8676002)(2501003)(256004)(7696005)(14444005)(81156014)(66476007)(76176011)(110136005)(71200400001)(66556008)(71190400001)(102836004)(6246003)(186003)(7736002)(8936002)(446003)(81166006)(6116002)(478600001)(86362001)(5660300002)(229853002)(55016002)(10290500003)(6436002)(11346002)(25786009)(9686003)(22452003)(316002)(2201001)(8990500004)(2906002)(99286004)(6636002)(10090500001)(66446008)(1511001)(74316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?j4Nec5CC6KzTHx4qCyIPCgHsfwLWEhRrMboGKYQ5wuk0rrAkYTIexWgN5t/A?=
 =?us-ascii?Q?h+LleLj/uZBDy1/dMp7iDfshuTnVI+bDD5Au8eBu8jD8ozY52IsRJNb/oJcm?=
 =?us-ascii?Q?rHNe6Kijli+CpjEHM0qJKi2zINTAbTYneo5jWEAyrpNlz5Gg7+/prTFH0xj2?=
 =?us-ascii?Q?iWhCnDeDI4jCUfFxtDI+E++2CxSSib6apyKXouk15hUUb5bUQdJS66IPyy8L?=
 =?us-ascii?Q?CbQPtb97uAItLFwC9rOEb0ZmcrLrJFPZ2J+LzLUkVFckf9BPkbPzopNUl4D/?=
 =?us-ascii?Q?DCI0Hc6HP3dJFhQLVCZggFEBVx4Q0/QkZrHF8WFXzstkN3TGAPs6JKclBA4i?=
 =?us-ascii?Q?rLlRcDnnMrI3VKjaK+Wh5vsEt7e3AsT/UGPblOjcK76z0wdzLXWaNHYbHBFN?=
 =?us-ascii?Q?ivKk/G9ulvFpH7+ntywb+Iug286GcXLb+ju37x1QeAjySnuzUlorNCoixLVR?=
 =?us-ascii?Q?LlwRnlB7bwh3W6y4+aQAEBPa84nT/uwPHHa6yysR8YuMOKA3HHjQWqZKxQJC?=
 =?us-ascii?Q?QXU9m869QaROuTt/MlK47+zF01zWAxC0iAVx6ASUkrWB3NpgosHAl50YSnDg?=
 =?us-ascii?Q?x3hzmJBdRkJ/GEB6kTvJXcSy7q3ZQVi4hhksBBcEhVcZkEzW1ZC6L4lgvzlK?=
 =?us-ascii?Q?0LT4vFvdSelDnwjjPomluSE9NqT+tkBs5KK7XZDDmOTGysqO2o8LO8hUXpR6?=
 =?us-ascii?Q?GS8IxV+IIcxM312FCZ3/c180zAPBaw1oyknxxcJFsNjf3HrdOGtCinsa/HD2?=
 =?us-ascii?Q?Y0IaamVc/SrVfhgu5R2O0qL3FaAJfPcsuDveT6HzWgRRfJ5orMaz/rxdg7LZ?=
 =?us-ascii?Q?kZhGsS21yRzIRnfy3quF6My+syE5/T1lvQ/GH8jjG6m4LOoKutj8PFuNaRRU?=
 =?us-ascii?Q?8PT563bif8x/bBlLIJqe+PUj5IgICbEx5sw6KdCLDdpKAjgLjNcE385TX5hb?=
 =?us-ascii?Q?FUHRtZlbcUeLwLAw/0iJbgX/rbVmSeIasu2rWJtloRzGmS4S1J6P2WiENwF2?=
 =?us-ascii?Q?e67JAapVEJKO7RNTMdV5tqjQsVYo/ojfWPZARCkYrV/w8NEV5CsCAaPqF/PL?=
 =?us-ascii?Q?9Az7b8QdlCjjd2lR62dtPEOVYzg7/z06dN2iOWjYHG3Szj1Es7c/gm8x/Xjy?=
 =?us-ascii?Q?PCtK5Bvu69QCFOn78tATYQK8A/lGq/BZjgNLntF9KgX7HQmMMZzlP/fWe0fa?=
 =?us-ascii?Q?jHqsVII/G/lx5frKZARjDFky4VrrFXGA0TCHlOY5C6Mvbh1+re2oXqk5iqHO?=
 =?us-ascii?Q?B/00o4QtnIxpOkUvaPLBBZY8i1TvJ0jxSmn/iOjBooUiAVGA0RkTgRojOjpY?=
 =?us-ascii?Q?RQLLnthV2/4KRqS6eUWcLelX73MMlIDyPtz+5v99uPQ+KXTcY10OnDmC8iwb?=
 =?us-ascii?Q?ocLYpWmxH7cHsWwsXyAvleXH4kfoigEnkkZzjFSXKJA3zLXlKaHCNxUpVwWg?=
 =?us-ascii?Q?ToQKYAOPQ5UzXF6pxlMl63P/DNo3t4tVz29w3s4yeA3KUxwwd/AxQhb2TM9C?=
 =?us-ascii?Q?eCcJ84sk5SjUJVbna78/15KlaxYYRO6knLrPfNiAj1coh71vtlsh783aIa/v?=
 =?us-ascii?Q?WGCK93OmoXHb37WdUuWyRc6tNJG5LfD7+Dl4mUCD0UKu3C6Uz5vlLMMkuM3p?=
 =?us-ascii?Q?A/SU7kt58kvHne6WiBTDr71Pu7W/Ojx52yOIW6TqFkj51nECksUbV9+XjaOT?=
 =?us-ascii?Q?zdTDLNDBR3oymQxspADqDQlagv1pWYwPT5quiYOuZ73y55sx45plSWVDPWSd?=
 =?us-ascii?Q?04QlL6AIy14/7uIa5sdL/YYmiRB4IXu2anQwtpmKVFJyg9bMOMHqZxMr6/mE?=
 =?us-ascii?Q?tC582b6zz5x6wepT03DGTLXQ96l6riEDtCP1+rlol9cre4qaQDFqSdEEWkVg?=
 =?us-ascii?Q?StW2B9EB0hZZiQHpkA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16209e3-1fdd-4189-6188-08d771f9ae8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 22:49:08.4211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ge2qB1lqrEQtLDBZMJ3nU99JX9Mc62cb+wErAzD6oUNZj0cTNuv3TA155TpYFZFnJ0LRtkRAIt6Pp1/zKhr9NW3v1ZaEI97MAZOdhlRthn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, November 24, 2019 9:34=
 PM
>=20
> Add suspend() and resume() functions so that Hyper-V virtual PCI devices =
are
> handled properly when the VM hibernates and resumes from hibernation.
>=20
> Note that the suspend() function must make sure there are no pending work
> items before calling vmbus_close(), since it runs in a process context as=
 a
> callback in dpm_suspend().  When it starts to run, the channel callback
> hv_pci_onchannelcallback(), which runs in a tasklet context, can be still=
 running
> concurrently and scheduling new work items onto hbus->wq in
> hv_pci_devices_present() and hv_pci_eject_device(), and the work item
> handlers can access the vmbus channel, which can be being closed by
> hv_pci_suspend(), e.g. the work item handler pci_devices_present_work() -=
>
> new_pcichild_device() writes to the vmbus channel.
>=20
> To eliminate the race, hv_pci_suspend() disables the channel callback
> tasklet, sets hbus->state to hv_pcibus_removing, and re-enables the taskl=
et.
> This way, when hv_pci_suspend() proceeds, it knows that no new work item
> can be scheduled, and then it flushes hbus->wq and safely closes the vmbu=
s
> channel.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
