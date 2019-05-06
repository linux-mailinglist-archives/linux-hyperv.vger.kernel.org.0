Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2E148A8
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 May 2019 13:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfEFLC2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 May 2019 07:02:28 -0400
Received: from rp02.intra2net.com ([62.75.181.28]:45890 "EHLO
        rp02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFLC1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 May 2019 07:02:27 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 07:02:27 EDT
Received: from mail.m.i2n (unknown [172.17.128.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by rp02.intra2net.com (Postfix) with ESMTPS id D88851000C2;
        Mon,  6 May 2019 12:55:43 +0200 (CEST)
Received: from localhost (mail.m.i2n [127.0.0.1])
        by localhost (Postfix) with ESMTP id B70C07CE;
        Mon,  6 May 2019 12:55:43 +0200 (CEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.54.20,VDF=8.15.29.48)
X-Spam-Status: 
X-Spam-Level: 0
Received: from rocinante.m.i2n (rocinante.m.i2n [172.16.1.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp-auth-user)
        by mail.m.i2n (Postfix) with ESMTPSA id 6AC887C6;
        Mon,  6 May 2019 12:55:42 +0200 (CEST)
From:   Juliana Rodrigueiro <juliana.rodrigueiro@intra2net.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org
Subject: Re: Hyperv netvsc - regression for 32-PAE kernel
Date:   Mon, 06 May 2019 12:55:42 +0200
Message-ID: <5083893.yzDQlZqgr7@rocinante.m.i2n>
In-Reply-To: <PU1P153MB01698936BF3332FCBF64D65DBF350@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <6166175.oDc9uM0lzg@rocinante.m.i2n> <DM5PR2101MB091875296619F1518C109E71D7340@DM5PR2101MB0918.namprd21.prod.outlook.com> <PU1P153MB01698936BF3332FCBF64D65DBF350@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Dexuan.

> Can you please try the below one-line patch?

Nice, easy one liner and it works well for me.

I hope this patch will be applied.

Thank you!

Julie R.




