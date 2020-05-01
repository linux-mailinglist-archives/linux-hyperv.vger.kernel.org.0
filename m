Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA661C0DBE
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2020 07:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgEAFfG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 May 2020 01:35:06 -0400
Received: from mail-mw2nam12on2093.outbound.protection.outlook.com ([40.107.244.93]:51585
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbgEAFfG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 May 2020 01:35:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STA9DQGeRVHjz+p6qI/71MR52cW/jMJ2DY+Oe0GpULevyCZf6Okl0FYg9l5c6AJGC4XTAKRU6fjGPrloqr02jj29Updr68RsEHbQmMMd51X6QkuOELs0FQra1qJskNaat6G3EMLBXnKcAYUKsMik3gbfQc0Tpn1UYk3sQDbaLdcpHMjNVEiaD5j8Ul4XIfcEITvJPCTnuFvg2bKeu/fY2oqbRBmW2o7vGRokhnrd8TRmhOt7hqxdVPhOfUIJEXm5NHruH3QcetRTy/fvOTOUWU4UxM/K+Vtpt2a2JzTcChJS1NQRlu04tXBr4N4XrliqOM2+7Y3M7+Ij9oKF/dERGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rh9luNE76MKdECbAXH7pNTxnmbJhEd07982l+DfWl4=;
 b=jFuw3CAHWC9PzB1q5ZROkyiXvtmH38u5r1hgMPPukdo649U+BHxP2gyUS7RUvD06Ec3WAw3b8syfuNKdSsIcZQTtgGxI2O3fR7AmGYwfivlODc/hlolv9Ar0u02MJqvOVdZ72PeG4n+dCHb37Yu5yHqgLQGyEZ2gf7jyc/lBh44XNOJpgF65dGinHF8dTx11YqAfH31o0Y3h1OOJ6EWgMO6Yq/EujIAvHrLt1rhzxBSLzX+akIRZWLXdfTgIw7+yTjjeY+2CsmWmEj3zF7BghrQDFDC7J6eoxaxItOTHiIXROIqBMzGnhHCtOX3wd00GWJdviDULKq6k72LvFiJo1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rh9luNE76MKdECbAXH7pNTxnmbJhEd07982l+DfWl4=;
 b=XB10f927nE0dN01Szv1BTmhxUuc9LP/2MDeeBG7xZrA5z7KaY7J11gQQ6CYOhsj8fZDcyST/SE9aFq4Wr0l9GSC8JCDe3dHT2NDqVFda/czZwKvosYggKpqBNR3+hI4TvAIg2aIQeWWebsKcYV8HL1wmTnSn02fu81v7S+Gcea8=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
 by SN6PR2101MB0992.namprd21.prod.outlook.com (2603:10b6:805:4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.4; Fri, 1 May
 2020 05:35:03 +0000
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55]) by SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55%5]) with mapi id 15.20.2979.009; Fri, 1 May 2020
 05:35:03 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 0/2] Fix PCI HyperV device error handling
Date:   Fri,  1 May 2020 13:28:42 +0800
Message-Id: <20200501052842.24620-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:3:17::26) To SN6PR2101MB1021.namprd21.prod.outlook.com
 (2603:10b6:805:8::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.113) by SG2PR02CA0014.apcprd02.prod.outlook.com (2603:1096:3:17::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 05:34:58 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.113]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f3760f0-0022-4e1f-d8fe-08d7ed91656a
X-MS-TrafficTypeDiagnostic: SN6PR2101MB0992:|SN6PR2101MB0992:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR2101MB09927937598E3433D27FCA7BBBAB0@SN6PR2101MB0992.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXbIIqc9cI+FDIxEH4JeBBHub99WvtYUcc9qeEjUPSUmkqEckYnHuAwWc035MW68iwJRXCeUEpw7aDL0j7KwLXJ4FCca4xqZP5TspZHkjMFwPX+nVAxJxpOg4ql+9WvjONZwIRvvKIKqcp4cniUOGioLetPsTz/c84yI6ydmvvTBq7SdxZmrQMknO7IZzIKsQrkK+2+iMOaZebHRSX/K5W1i+98nyKz0jLp4STZa6dh4Ip7Gvv1L9mDf9Mg6QfrtboZYEzCxHiro52BqG9mcJkkZheSfYegpjDlR5MsN7dfOJ2GJCE4XcjQoUFrDbEOQrMvW2o14dJ6T5ptjVITsEKF/VtEA5ngBRIxCw8KjiqS25THcrdGrqZjqgv6uoqpb+TunRaYHDNq0bQ1cZ7TziStMnp468cA4E0FEk5YL9XrtYyPPwwRLVvLAkHh4LzJ40qreSuzXzECQUbMStGnpxpE9lVwbUXs5QusrGSjaVkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1021.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(16526019)(186003)(3450700001)(8676002)(8936002)(5660300002)(26005)(6486002)(7696005)(52116002)(4744005)(107886003)(1076003)(82950400001)(86362001)(6666004)(316002)(36756003)(82960400001)(2906002)(10290500003)(2616005)(956004)(4326008)(66946007)(66476007)(66556008)(6636002)(478600001)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /AmY8B+jpcTYzCDrsWiBNb/eulntPJPA/DvgpSJbB/gUtsNNP58b0Ny54CloySjnPydOlV3h3sH5MPOW63UxC/IeK+cpFMUOZXxdSEFzkR85X9TdBrB5Wjzi9b4HBe5Pe7Vr4c5M0ynt1p2V4N/y9mqbdTzdBXPn0ClwumvyVkzka8KYE0L4bFwOIXN5lU4eYcuHKbHTJUj2YEOKzNXezQ0t7FpCNgPY++6QEeDS4vwz+c2yZDCHV3sIr02SQwcFV/FLaXwDyCPrshQpJJyn/+YQhqRrtVOUisBXOnevCX8cmU3CwXNU1PtbSla96PnSwctfjvPI2WZAv72GqgGzB6PXZ4fmgJaYWojiZD+mieoTxFvUs0lhKlHpERzrU35A6KQTlBlJJucq9d00i9vGencOVWPltxvVvZCqong6RdYYn10THpgu6TtwKUYWc0Ct7K9plaCaF1q7hAq+ludeZdG3nzjbhBrjokIA6BOZ0zYx1D++6hlVbsYqDO2VrnYe7Mx6uJxZVBnJ8mP34ri6IJeUQ/E1OcAcCCH48Ktd1U0ZldV9onT/zO6uRUBlEPqw9n00JQ/YIcaBeXgljwKLzSfdPnUla8C0CWmTecZBcho11zG5k/1mqfqF48wDQeybKWeAjKKmIJUTMvALbsznZILHjJqqdpBs4W5HD5ypCp4RSFQdfYth6Lt5XLWm8ZZr6lDoPzeIv4wVkza1qsXB12XgjODMlD0h5h69CDgnPb5IwjkzyZPea4T5HF+X98qWq9n9vmhr6voK1/5nnkeZXNzMgInOXS0sABwJsWW04UAGf5FMrkFkHByEP24weoA3
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3760f0-0022-4e1f-d8fe-08d7ed91656a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 05:35:02.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8iFM5mM4Do7wNHY/O+DlmHC7b+VvIHQW5h3XJW1WK/Xjpt04axNeuUX6o5OQudR5kFviZ+ahRNg7G5B4Hwpc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0992
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This series better handles some PCI HyperV error cases in general and
for kdump case. Some of review comments from previous individual
patch reviews, including splitting into separate patches, have
already been incorporated.

Thanks,
Wei


Wei Hu (2):
  PCI: hv: Fix the PCI HyperV probe failure path to release resource
    properly
  PCI: hv: Retry PCI bus D0 entry when the first attempt failed with
    invalid device state

 drivers/pci/controller/pci-hyperv.c | 60 ++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 6 deletions(-)

-- 
2.20.1

