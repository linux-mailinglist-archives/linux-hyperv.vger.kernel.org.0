Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3805100AF3
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Nov 2019 18:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfKRR7P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 18 Nov 2019 12:59:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33241 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRR7O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 18 Nov 2019 12:59:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id h27so10008020pgn.0
        for <linux-hyperv@vger.kernel.org>; Mon, 18 Nov 2019 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7EYmZ7NRTxHkOWSbSxQ0gywzZ0Cdf+FfUYZH7rtEdQE=;
        b=dLIQEzcwJz03sHkX/zkGpM9f5gUe4Ym6v3uAIwg37cDxKuvpfBDkJEaQpxzKHzK5fv
         PwiH8ZdFLgm9mi7G+FxOTJvbzKFvKbp0ZgvV/+/9eTdRu09rUCCIgt5Tijrm0oYfy6vY
         ae1TO3fwnzHwp3RD6ch5hUmBkvcD+bd+BIxgPXQNrpmYl0ys7jhvyb4EoYa0Z8UumCPo
         gh6FWfkUDYgGqYD38BJRkMEycx7slcYj7Jq8bjTk9qSQY/FFFun9JXxsrlxiyZ1WepyL
         7KFFRRVvozD2Fp1TqFeOS5wq0MPMFwO17JNiyIJpw+vvX/Dh4GK7wqmIU4GXaHYcgUuq
         WMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7EYmZ7NRTxHkOWSbSxQ0gywzZ0Cdf+FfUYZH7rtEdQE=;
        b=JcTTC398+epauny7CMJj/kgrGxJSYOG5RtN9Ithr8ez2+0/7c3YnqpbwQdcWKRsNyD
         2UQNiT+N6XsSQrWjYd4Uh+W/nirwV9Q/S1/gRAK8XB0dC/OkUsHSydTXl8K5G052wCZs
         Fi9E8/kkspnhDRRVCyAbkCafWYN92pFhZiCHT0YCpQu/mEFBdxTdJyDr7bdAHd+NnZX6
         vLMra7uMa2DnTdCvmQ/I65lwjtE9m8oI2E0l+6SR2i/s39yppXBG0jwXaX8TI2FQB/FN
         nrN4sTjUJGRK+f3pM1OE/Bq5woWuOYyNTGD88f4+YAJvYeEYvyM14Ub4PKkuTuDvcrXp
         neGg==
X-Gm-Message-State: APjAAAUd7TRG+UOVeURpk4TsISgeRzo7mQ2lLpbo+8FnCbwjuBTWRlq3
        82zac9xUNTHyLLlYtha9EyafYA==
X-Google-Smtp-Source: APXvYqwe244ck0Ha1OOKUd5dlfDyynPE9re1cJMR8bAB5hw9pzDlUwsH4z+WwCavWNf8pM4H24Z4bg==
X-Received: by 2002:a63:f40e:: with SMTP id g14mr623031pgi.132.1574099953908;
        Mon, 18 Nov 2019 09:59:13 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r16sm18525557pgl.77.2019.11.18.09.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:59:13 -0800 (PST)
Date:   Mon, 18 Nov 2019 09:59:10 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net, 1/2] hv_netvsc: Fix offset usage in
 netvsc_send_table()
Message-ID: <20191118095910.3566c5dd@hermes.lan>
In-Reply-To: <87wobxgkkv.fsf@vitty.brq.redhat.com>
References: <1574094751-98966-1-git-send-email-haiyangz@microsoft.com>
        <1574094751-98966-2-git-send-email-haiyangz@microsoft.com>
        <87wobxgkkv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 18 Nov 2019 18:28:48 +0100
Vitaly Kuznetsov <vkuznets@redhat.com> wrote:

> > +		netdev_err(ndev, "Received send-table offset too big:%u\n",
> > +			   offset);
> > +		return;
> > +	}
> > +
> > +	tab = (void *)nvmsg + offset;  
> 
> But tab is 'u32 *', doesn't compiler complain?

nvmsg + offset is still of type void *.
assigning void * to another pointer type is allowed with C.
