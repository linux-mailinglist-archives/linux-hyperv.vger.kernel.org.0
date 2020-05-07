Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538961C813F
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 07:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEGFB6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 01:01:58 -0400
Received: from mail-mw2nam10on2136.outbound.protection.outlook.com ([40.107.94.136]:33760
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbgEGFB5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 01:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COFbjXvK427lEZv1hdRy8qBqpJ51cRpjlPftcZQbaASFZq69P0eAUmISuPD6g07CEfXp3bQ6uzdaXhv6ugO0Mg8Zs9XuBo6q0OHR+yljzNWSQX8qAaiD5iQw76+4AiFYFA7ZXoQpiDofNqrDeiGCTc66DuAJaggePaEYWTbCKQmDpbI+9QFoo1rFFgoxSLPhWD+s1aNTHEcIOPxgS6RHk0z6yKF5sJFLkUOuUik0bNfhvrg59ez0qdcboLo2ulbroU93PdSVZJ/S7HHi3LpiGSyo+5js04cimCNeBMNldfGPEepyBn3FFK7ShUFAOTY/zQ5VQFjw0QddHXjccU39Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo2WLDpFF9U213Es6NQ2fn14P2WsuE2jj9Mo3Mou2Ag=;
 b=WBSRq3kgs/UJqUxESrv0us9h+SYlPuwGX+v2VDuZG4v7ybL1cC2bBHkfZp5znIHrSqPR+/8IYd6wez2dQ7P2dQMdZJ/Nks8Wa5n5nqh9lixKg0ZnM/5zRUjESTLHaVaxVKqDA8ltsg8CcbMD98Wv7/IX6HgEWH57XcmeJkicSgtgX7flph7zKY8FbXUDVEKEdKrHyckIXd7fhWeSsqeClTzPmN2craolkTrCTD6nkXNvBPxSoVysV9/PL8EtCxLiULYIiGnP3KWK64RWwhxBA1hdGtbl5hsHySQlF2gz6z839Q7d1ucMG8ekXE1F+zOYOZc/46nPNdkfXvDEh6sC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo2WLDpFF9U213Es6NQ2fn14P2WsuE2jj9Mo3Mou2Ag=;
 b=e4oPcU/aSREu0XLy3ObWJYlag+U2a6GB76uawGjn8vQK7XZpK7a3ENEz+IytepU5bEA6AuYPwYbKk1vKg42Ch7Vy3Rbo04fGtPfuu+RJNgt3GYmyPwxnqUgDZ7qYOcuRh1ESHn2vU17YUqBWRhF2jI3VqEU+EvpxLjJWr/8DvXY=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
 by SN4PR2101MB1584.namprd21.prod.outlook.com (2603:10b6:803:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.3; Thu, 7 May
 2020 05:01:55 +0000
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55]) by SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55%6]) with mapi id 15.20.3000.004; Thu, 7 May 2020
 05:01:55 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 0/2] Fix PCI HyperV device error handling
Date:   Thu,  7 May 2020 13:01:26 +0800
Message-Id: <20200507050126.10871-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0150.apcprd04.prod.outlook.com
 (2603:1096:3:16::34) To SN6PR2101MB1021.namprd21.prod.outlook.com
 (2603:10b6:805:8::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.113) by SG2PR04CA0150.apcprd04.prod.outlook.com (2603:1096:3:16::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 05:01:50 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.113]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97b4484e-8f2b-4859-ec63-08d7f243c304
X-MS-TrafficTypeDiagnostic: SN4PR2101MB1584:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN4PR2101MB158444FC7398CFF8A3E00F3FBBA50@SN4PR2101MB1584.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUKkA2pUUvbN5H/bqIFVjlX2reyaMT1QfTDGNLY217CzV4KxBu+Rhi5m4UilC8h9J3EI0apM22hEz54iuMyzc2w2r4OA24xDYmOwzKimdfLnACfUo8dGOeARSqQRJX8yraoKlmWnsIGcELYnryQBbiq3Y3soMRIl+Ug1C/NC0AF9oJWxzBb90+LUefl/WT4NvjzvwokvcG88xGjPBvjocY50WgkiS+2gOvZM3ulZ95VEAwJN3puYO7lFTcsCqbEqR/QIHah/dwQnVzQcsKekSkqGS/TZtQrhtRoVwQ3h0vpaPbgvEqiVmNLrQm7ZmMNjeWxUjFqatkreQmj6OqM0qBNvmj2TGe5EYoFsF0A4iZhzsTqeEhV6ftutHMNmF/apKOedbG80wf55t4XumEwc7dJVcUDrdMotolDKj0YgtIJgW+tdI6H6nGCwAFvv8q/q3KcuXt/NUbm9zAklx6hEYpMZttXQi0wWdAiW/+5yT9m+7SRex0XUKfNgz9SLXKTd7awtUnhuYcyCI1dcVfY2XTWaDjgWIwdDhjx7hFStEDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1021.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(33430700001)(82950400001)(5660300002)(2616005)(956004)(4744005)(478600001)(10290500003)(316002)(1076003)(83300400001)(83280400001)(83320400001)(83310400001)(83290400001)(66946007)(3450700001)(82960400001)(4326008)(6636002)(107886003)(26005)(7696005)(52116002)(36756003)(33440700001)(86362001)(6666004)(66476007)(8676002)(186003)(6486002)(66556008)(2906002)(16526019)(8936002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PkX/OsGbU3uTzrqoLQHMomacSFXk1a4zmQHJuo59VpVBiAbtW9Z8yOiRpbaIptJil6sLG7P6p/+gOaOZYqCmn+LiOHBCDybp/gh33K4e6mzJ3jMgCtYKHdgmUCCQZ94JJyldc6xOquu48hVUFMTwbkOMdDcggZx+kmJ2mbKuwwsUEgAYtQJoG6EnSSKBI6DrSgTtMYejuD+g0eDhk5MY7Lr38Zrarf+RR2Wh3nstlAJ1XsRGdMHfCqdKwR6fbg3WmB/RIQF26OjPMC66M1BxyUGdGeBvC0UN7ugsxLimA+zslS+zny7XqUi2H/nsCb/k1X2/lLHJOyKDsi4Cj87XZNp+FhEQ537IYlHjNOHHwcaGae4unAM5hN3MsEyyVN9IgU6uMoDU37krLWvTzv3x1yzhca3k4JqiWhAuOHke9y5MxZ1IYTy9FL/KSdBj5mn5XubTkXeJE0eA/sq6CPGg3RpEcK1J8BsFnGh/ldhSfVf2zSQv3BdEJucfiZu2xXYN7xlDDHxfpAX29ZJXolcvaE6DU6fy1uAwjnPV7DhSniG5jYBZ5dc9qc06LesVMf/ya4xnKPsorYJRhej4dSybGVKtBZ7sjmadr+QwxH4nvL+VRjl1nI4pggrdzZenuS4eH7PEmSAcJ8YiichcHmIk2kX205cxxduaIXZHHFU3TuMjayT/QpsejiQqnC2HInzzlrbKr3Ctn5P4bGbbM5zhF9WvRxsdUaY5MCoEvan8NWp0VBHkKcNQeIPbhAoVbc6ZDOBG5EhSgqodPYUCXcPm8tPyX5Hy5FjU3XrgCraBdsd4nY7vpGU2EpGu2B22Zgxx
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b4484e-8f2b-4859-ec63-08d7f243c304
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 05:01:55.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+VYEBxpx0VsHJcimrZ6uK4/DyLt90DYDJuCo53gq4vuW6DoCSes1XQN4dMboQCTNOvuWwmfUSHe+RUtaPTCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB1584
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This series better handles some PCI HyperV error cases in general
and for kdump case. Some of review comments from previous individual
patch reviews, including splitting into separate patches, have already
been incorporated. Thanks Lorenzo Pieralisi for the review and
suggestions, as well as Michael Kelley's contribution to the commit
log.

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

