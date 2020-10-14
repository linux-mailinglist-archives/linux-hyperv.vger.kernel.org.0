Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B128E33E
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Oct 2020 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgJNPZM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Oct 2020 11:25:12 -0400
Received: from sonic301-20.consmr.mail.sg3.yahoo.com ([106.10.242.83]:34916
        "EHLO sonic301-20.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728328AbgJNPZM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Oct 2020 11:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1602689110; bh=k6qD474V9VtXKDobcCBmjOJywgarZvgPlTt0r+34qBY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=JcfTAFzrEM0wk5s09lq3Vie0Dfv74HGy5lcfPpb1IIBOL/CFaXR1daHiCG6V5tx4QG0R41x3/fZl5xwCSZmTxKssOQePX7WpdP6kO7lY4to2KMlkjJ3j8h2EJTQo8HuYdTajRXUH1OUQk2Ez3FNWBiOsRhDmREWl/YhHyA4bsig75eOYhZHASysBQuUcV3pan0T7ip7giR0rkqRsqUpt84l9GgYwbgKdyOafAYmtOmm26nPeDo9VDnZm1ZwBzPE4Q9klSfgjpFDohFNNoB3rTgg7xOKKWP+HgE0AUQhTXPp/5aTuGJWLXjb079MkUSkAiQIzvfPcUm1fOnZKLoktYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1602689110; bh=RmboPT3KXOfdNta9KO+xpZCHzf8nDlDXYpDZwGFLimL=; h=Date:From:Subject; b=Gmb606oYyFFJCNA8u2PGYD5Dw/nWhryXcsVo9WPVNnwUg+E4XNf7fG7CNIjq1dA9ihO+1u+eXG9kM4RIH98k8zoa/Dth3xhxai8HKYQs0Zd4rE+UqOjwEQjQoYbiMj4484bRGElQh3LnaaqgVlL8kNQUvi7Nl1I/zmm7IV4i5dZouYU2pa2+DBRK7Oe0tr391kvTFaPL/Vb99Tyf90gapQbw30rPa67yF4wZEBqMGs0xz7KGD71U8zx7ums+dgc03ybiv2bnc0jLdKOGLFFk54rDVOn/1S59jrjkUGRNHdT0+mrSzh5MjTUm+yKqfZN1d6ntymS24k3Cjl+d5koNZQ==
X-YMail-OSG: P2uzgFkVM1mo9A28zcgtkIGFYydZIGSUUGXuEnyJp60vR8q0Cyn61.SD5ClNze2
 _6BwCHmIn8tMgVZeE3JVNAvcBKGQRLonxjSkXxkyCfjWX9gTcbf0ActIncSBVndqyzwuQzp14Yur
 S9kvB7nsGe8JpkB_TMEpu_fi1IFZkuJulJHgkXxqmgDIzfcPmqKnnfnrl.GbqZjpxM6vrMNu1OEK
 sD7fsAnCM2MXJ1pRl_zGthrd3cZJ_C.SkAV.Oq_5kJDl_lHir6az_TBp7_mK1oL4l1rSXB4EsjJj
 QsMwEF5xqz3GM_dBT8Ts4XX82C5wFB0qNbE_ihmWwzbnUwEQQ4XBVyk0UVhAd9fgVtwi_vIPFHpo
 1CpEL3rLnrAlePKwPWTEmduxFuhvi9AaGa1suZ36W2cjktk3S0QRUW23QglwXtSE9nf1lBpXxOBH
 0EYSD6lImVjBwlYQjgXznROWy.MXehRqnvzrLGq1wR0e45xKgNIfdkKUIxlnhVToFNJypoEx.dzv
 7HMfxMTxuskv1dyueivyrEynrGHFeEL1GgXctdR9Z28wRsGeZ7iDSBZakpF6DdDOtBKjVrhec7tx
 WHm2y525tWYT46m6cUEkQHdF_OOh5rXVcO.tJc8VpWzZ3XWABSsQTW51qLiUvQDqFg5X8k1svEtZ
 nHnQc.3HpSq9MG1Y_npqu_3PefuZJpsSA92BiGlmuHNpRiMkkynPxsG3P8Im4D4YEdHL9y_tc3cj
 Qm6eHSIELYANEioGz4W0AUA1ImgA5oXGJ0orwZ.9G5.pCrAn7hh32Pd8gAXDxdrEqAohZsz49.Bz
 h9DtKTDYJvnTAu9NByYKcBmvrwCAgvsb3SuBlDbf7.OMEfagPPuXFb.uQgjoUu7XX5QYEY3uqiAN
 ABfeNoXVe_x_o5hldoWtTXKMODRz0IOjjN7kBYyhv9w7fAR2zyRCcs0nf707IG5tF1I5PX16oK.T
 DN4qwgU3pGGMY4Z98zDl8hsW99NPmC.YUnFK4XO0vwwT5Vw6k2dSukbV38zFB03M8tyX3z1l9_bq
 o8IizIilczAHfN5mciBTbs_fDr7RWwQSIzWPv11GmObQN5.HhGKRK_VcbDxATS23d9ZwogsZsba9
 yXt28p7ImoAgT29Xb9fB1IqjNFT3bG5rmqCJWvqxZEswsvmYiL1tEVfYHxgICbvMPIRlKr2qDxst
 m1cMgE94f9uW5vJXATbcJwkFWAucnkR5tIR2EBFxkfCf8H5QosU0CkoRU0_3UAHKJcMfDP36UOX7
 bREamIm06PbmZY0NUAFVF8XP4_ZUJwTGij1Z5WuoaZhDOX7oI9znMYKcZPrO7TrfLLxoJu3tv4NM
 MH96lzXkZJLTPRy9huND9w.b52S.Gng5Go02acm6kjoplcsY.zErlNNVDYHKnovpDTD_jB0jqY1a
 FaodNGc1lp1dw9ljrpUm9aB0FVnjUUsWTGkjuJ7VMgjtyEGWDtKoSu3KBVN7beRrxqGHzcjYBaOn
 skdJF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Wed, 14 Oct 2020 15:25:10 +0000
Date:   Wed, 14 Oct 2020 15:25:07 +0000 (UTC)
From:   MONICA BROWN <jjjjjjj.kkkkkkkk@aol.com>
Reply-To: jjjjjjj.kkkkkkkk@aol.com
Message-ID: <1954243105.592659.1602689107135@mail.yahoo.com>
Subject: FROM SERGEANT MONICA BROWN
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1954243105.592659.1602689107135.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16845 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I am Sergeant Monica Brown, originally from Lake Jackson Texas. I have 
personally conducted a special research on the internet and came across 
your information. I am writing you this mail from US Military Base Kabul 
Afghanistan. I have a secured business proposal for you. If you are 
interested in my private email (monicabrown4098@gmail.com), please contact me 
immediately for more information.
Thank you.







