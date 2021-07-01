Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE97C3B93D9
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jul 2021 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhGAP0r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jul 2021 11:26:47 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:43904 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232817AbhGAP0r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jul 2021 11:26:47 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2021 11:26:46 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 955D4180222A7
        for <linux-hyperv@vger.kernel.org>; Thu,  1 Jul 2021 15:16:09 +0000 (UTC)
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 09FFB182CF670;
        Thu,  1 Jul 2021 15:16:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id E6EFF2351FC;
        Thu,  1 Jul 2021 15:16:02 +0000 (UTC)
Message-ID: <59794f7f5a481e670a2490017649a872a8639be2.camel@perches.com>
Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
From:   Joe Perches <joe@perches.com>
To:     Long Li <longli@microsoft.com>, Jiri Slaby <jirislaby@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Date:   Thu, 01 Jul 2021 08:16:01 -0700
In-Reply-To: <BY5PR21MB15062914C8301F2EF9C24F15CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
         <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
         <f5155516-4054-459a-c23c-a787fa429e5e@kernel.org>
         <BY5PR21MB15062914C8301F2EF9C24F15CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.90
X-Stat-Signature: dsf3h6ga59m8sx4ehmp9tsmrym5oi8tz
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E6EFF2351FC
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+tjnrxZq5D3ZdkY3toM7Ry7rBvXa0HGQU=
X-HE-Tag: 1625152562-567931
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 2021-07-01 at 07:09 +0000, Long Li wrote:
> > On 26. 06. 21, 8:30, longli@linuxonhyperv.com wrote:

> > Have you fed this patch through checkpatch?
> 
> Yes, it didn't throw out any errors.

Several warnings and checks though.

$ ./scripts/checkpatch.pl 2.patch --strict --terse
2.patch:68: WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
2.patch:148: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
2.patch:173: CHECK: spinlock_t definition without comment
2.patch:220: CHECK: spinlock_t definition without comment
2.patch:250: CHECK: Alignment should match open parenthesis
2.patch:255: CHECK: Alignment should match open parenthesis
2.patch:257: CHECK: Macro argument 'level' may be better as '(level)' to avoid precedence issues
2.patch:280: CHECK: Alignment should match open parenthesis
2.patch:283: CHECK: No space is necessary after a cast
2.patch:287: WARNING: quoted string split across lines
2.patch:296: CHECK: Blank lines aren't necessary before a close brace '}'
2.patch:303: CHECK: Please don't use multiple blank lines
2.patch:308: CHECK: Please don't use multiple blank lines
2.patch:331: CHECK: Alignment should match open parenthesis
2.patch:348: CHECK: Alignment should match open parenthesis
2.patch:362: CHECK: Alignment should match open parenthesis
2.patch:371: CHECK: Alignment should match open parenthesis
2.patch:381: CHECK: Alignment should match open parenthesis
2.patch:404: CHECK: No space is necessary after a cast
2.patch:426: WARNING: quoted string split across lines
2.patch:437: WARNING: quoted string split across lines
2.patch:438: WARNING: quoted string split across lines
2.patch:458: CHECK: No space is necessary after a cast
2.patch:459: CHECK: Alignment should match open parenthesis
2.patch:464: CHECK: No space is necessary after a cast
2.patch:465: CHECK: Alignment should match open parenthesis
2.patch:472: CHECK: Alignment should match open parenthesis
2.patch:472: CHECK: No space is necessary after a cast
2.patch:482: CHECK: Alignment should match open parenthesis
2.patch:506: CHECK: Alignment should match open parenthesis
2.patch:513: CHECK: Alignment should match open parenthesis
2.patch:519: CHECK: Alignment should match open parenthesis
2.patch:535: CHECK: Alignment should match open parenthesis
2.patch:537: WARNING: quoted string split across lines
2.patch:538: WARNING: quoted string split across lines
2.patch:539: WARNING: quoted string split across lines
2.patch:549: CHECK: Alignment should match open parenthesis
2.patch:549: CHECK: No space is necessary after a cast
2.patch:565: CHECK: Alignment should match open parenthesis
2.patch:574: CHECK: Alignment should match open parenthesis
2.patch:595: CHECK: Alignment should match open parenthesis
2.patch:634: WARNING: quoted string split across lines
2.patch:639: CHECK: Alignment should match open parenthesis
2.patch:643: CHECK: Alignment should match open parenthesis
2.patch:646: CHECK: Alignment should match open parenthesis
2.patch:648: CHECK: Alignment should match open parenthesis
2.patch:650: CHECK: Alignment should match open parenthesis
2.patch:694: CHECK: braces {} should be used on all arms of this statement
2.patch:696: CHECK: Alignment should match open parenthesis
2.patch:703: CHECK: Unbalanced braces around else statement
2.patch:724: CHECK: Alignment should match open parenthesis
2.patch:744: CHECK: Alignment should match open parenthesis
total: 0 errors, 10 warnings, 42 checks, 749 lines checked


