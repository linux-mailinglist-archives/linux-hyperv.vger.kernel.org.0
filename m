Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD252EF9BF
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jan 2021 22:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbhAHU7q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jan 2021 15:59:46 -0500
Received: from mail-eopbgr700127.outbound.protection.outlook.com ([40.107.70.127]:51041
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbhAHU7p (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jan 2021 15:59:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+W1FIk9nhK4iG2h8Hqsy76D8wJetTqRfKfCl8r/9g8/rNTdIDdjaudI/UIE9ISqcP3jWt6NmU6rfNiPbRBptSiaqGEZVuwvEwTQuaJApQSzDrUdrz/ORYbZxBqQoS12bv4zWT2zl8V8sjy8gviEnz/eDRhZUd7NEItb1bDKyWKyDMhK/+Dmyb8UAfpIE8gH7THNuFXSxbupDrcwmIa3SV6qY3j9PsuhBElpKQg4oXf5FdQnAqzoALpl84Ig9zZLjT3kEKecu3uaQTBz1AuEkxkrD24b7P9MmP+uZvxzRbgwE0GCTJSDrqTYEY7qrpXR9CUF1bhaoZ/MbqNg5suWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktIF0gpzg9V2i0o3FQEE0Raj9a3Er7WLNkMLBNuhL+M=;
 b=lg5SnWjphnck+weKFSQPpHd50KzZbf/iEOEB8G2YeuVt2rmQq/tWufSCGjBfDgCos7DJjxjmGNkC4IgQdmuvULG0qrkLJDNR9I/iKPuyIhh77ybCpgtXUjyDvXeBvM626bXsmgL7YmLsUHZ8vvYpGG+XP6wlHyY3sgK5dw6i2jE9PabyCA4L2ZEHlsxqyyenqUHLoyLEBWFrSGDrlUY5fEsmptOQo+sfhP5wQuzTa6bJM/mrXm9KNlZXFjUDKbOqVqd9q1M5ayT4DZRYD42ZSRHduKPfFYZLETb4YDdP5aAB3u0xvaOcZKXl2fo0qb4TEpqhHWgXGKy7estrAyJT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktIF0gpzg9V2i0o3FQEE0Raj9a3Er7WLNkMLBNuhL+M=;
 b=QjUsWKSUO+OUu1TJKPP6LwX/kK+4f0d5XPH9f/Dt39nG/JAd7UfKl67+7kG4tX1TO7NIXdUY+oK0GKnrc5G16nAejKT0ODBNoq97e2pRlnHtMnWciFov0JDpfQLcUCDQc9tHd0ux6UYp6QkAvihxMMO3umoSeCxhKGpnbff38oM=
Received: from (2603:10b6:803:51::33) by
 SN6PR2101MB1773.namprd21.prod.outlook.com (2603:10b6:805:7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.0; Fri, 8 Jan
 2021 20:59:03 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.007; Fri, 8 Jan 2021
 20:59:03 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/2] Hyper-V: pci: x64: Generalize
 irq/msi set-up and handling
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/2] Hyper-V: pci: x64: Generalize
 irq/msi set-up and handling
Thread-Index: Adbljt4x9C/tWN57TcS7/Z2kriU9tgAa8qSAAAGX89A=
Date:   Fri, 8 Jan 2021 20:59:02 +0000
Message-ID: <SN4PR2101MB0880A71F4AFD5BF20411C674C0AE9@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB0880A1BF1E62836EED4B8358C0AE9@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <20210108201259.GA1461930@bjorn-Precision-5520>
In-Reply-To: <20210108201259.GA1461930@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:cc35:9c0a:9ae1:bd4e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36ea7aa5-2f8c-41a3-06bd-08d8b4183ace
x-ms-traffictypediagnostic: SN6PR2101MB1773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB177371E45753715B5D83780BC0AE9@SN6PR2101MB1773.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKo/csD3YNYziAnQ9y5zSdn5gOdNrYmK1YzC3z56i+cee9mlw1qpUZ9AeVMQDHpI5QbIiyGW3WS87pMCIqLF3Io7t4mcrioOKzQFp0KFmmolPwO7WRZnjQBqEQnRVyN/eNcMl/ci5o7pOgXrMyEzw+jpXCrzbSdie1QryR9LKhQc8jB/sEAQMX3BRTmOMO4wRrnsjipsREShbFOs568qEMppylB98VGrPATB9mkvL/3FzPIPiH/souoBvEAKDGHQhfLSxSrKdA0U8wb0I9AqX7YrNRcFKo1D5ZCShmm3QXEWyqEpKvbhZiocRNFHDKsM38sIpRmNJvIiXzuTcLuF8DwzEkwhXZVxH1BFwIech46TNEjSfEZoT/+oopiW8/nsWQBU/X4PswKqQetoQMeJsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(55016002)(5660300002)(558084003)(66446008)(4326008)(52536014)(66476007)(8676002)(76116006)(6916009)(66556008)(9686003)(10290500003)(66946007)(8936002)(64756008)(478600001)(82960400001)(8990500004)(7416002)(86362001)(71200400001)(54906003)(186003)(6506007)(316002)(7696005)(33656002)(82950400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f6zY/lxInJdW/7A/vczlGHy/TCJwuSEjFQB/oM0gjKFaTPW9+ZRzijW0c1rR?=
 =?us-ascii?Q?co8JIBP6aMXUnLdsya3BqotGl+1faa3XwX4SSCVlu6791g8lJG6jKB7B59S9?=
 =?us-ascii?Q?dVI2tMgF0zHcopj0r6qhYIDZWgdWR0pENpA+zaesxgP1lS+YUMzB3FGWDnlj?=
 =?us-ascii?Q?OHwQzr4Q9ntkoQ4Z4S07+pn7Gsk4AW95BG3fhpRYrbPf3HhUTd9aPp9j0FJ0?=
 =?us-ascii?Q?Lq2ddMrU2rc6oaMt13ynMtDlTveaV5uAxLYxS0QbRr40PrdXYE6XaKuk1Tpb?=
 =?us-ascii?Q?UPkmH5+BG0Iqzy7LeNeV6DzbYgbrj2n1S7oCsHlNIyKohsu9Tv9NaHCcRxuj?=
 =?us-ascii?Q?GrXtE+974jgFnnMIabOh8yWZFUTNMYUHetVi9L4klYhLqV+vDVI9I0SZb1la?=
 =?us-ascii?Q?tHvC4BUVaSkHZAgLUIrOUrbV78PyixLuIQGyZLp0Nq4BUyPCKSdmsFe5rcKb?=
 =?us-ascii?Q?WuMWAoeiVakp+izvZ4JFSIlXv8MpOd6ftTtyvZfUpNUbJBjaAN4zHu7TMTNX?=
 =?us-ascii?Q?7Dqgf74ejqqgUKTb+PgFXsFpU41ZkcN3UbY4m97MbTv+3vEAdehb9DsaFYoO?=
 =?us-ascii?Q?TUBtYohvXT4hr2K60Ds7xq0ELlF3GUUyB04Xw0rO1TbRtQfJiyjpUXB9QYdo?=
 =?us-ascii?Q?qoy4jb2fH/RZ10Z81MbqZYsdNQaGsxQiRycBc+aglBIatKvDVWYnXDaXHcGg?=
 =?us-ascii?Q?cINromdCF5q3cRFi0y7WFCJeYc8DTsJquevwCbFRAuiue/Up002S4JT2cp6d?=
 =?us-ascii?Q?4+/x2+fMS+W1n28mPWFuj0O6NwjOeW4QGl6gH74PJOZcRVYMZhdzzcFQCttR?=
 =?us-ascii?Q?70+0sYYnyXpNk6GV1TJleg2AXdItXKNvXQ7uwkphNje1Dy5wyAagw/rwf7v9?=
 =?us-ascii?Q?VIDTcbSloSyF/jhWV9oP08fU6gU6zqyFoW+jUF4ItqiLq+/j5eDIZXCP3OR4?=
 =?us-ascii?Q?MAw2sN2woz4fsG9kGZOzCdYouHygdjorwR+PdPHozKwtlRCM8C34tgkNiweb?=
 =?us-ascii?Q?ADivQ/SrUEeMwqMSzC2MX4M4D7FQwbhQP8whXt6Znm3NEdo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ea7aa5-2f8c-41a3-06bd-08d8b4183ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 20:59:02.9634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAH2cq6b45WERpnh9rtOylQLg3QU2Cx8DAWDaRkPqoPImuw/PjdEhyYm1VYxqlrCUKJ+PPBhc7bq03vT6JFokn75KVeDUu7kZjGqoB6tOlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1773
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> At the very least you could pick one of the subject line prefixes that
> has been used before for either mshyperv.h or pci-hyperv.c instead of
> making up something completely new and different.
>=20
Will keep that in mind going forward.
