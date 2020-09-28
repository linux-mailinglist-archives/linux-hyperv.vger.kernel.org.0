Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11D27AA2C
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Sep 2020 11:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgI1JCX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Sep 2020 05:02:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39510 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1JCX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Sep 2020 05:02:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id k10so341784wru.6;
        Mon, 28 Sep 2020 02:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=32QwR42HFcU9ojGJECj3ZA1ItJ1AvvkKrKA1NI2UEZw=;
        b=I8BggSFNrjDd8OP7LJxvQNp6baO5wA8u23H+DWC53Po/ZQ9FeG6Zu9+J0zk7WOO5v2
         J9YzX29uJdfVTHPzbmGCnsfU96RO3Pr7dNrO6qqxeuR8HMMW4mCNeK5JD1X214hwRRR1
         r68Hwia5UV/Gp+t/s+E5Bf/831WePf/yCrhNPciqFM5Kipq8Ac9aPnK895mGylkBxifU
         MrbK5JSrYHC9gaMcNMFQnlInmh1o9dZGF2NOgP3ePTimyTAEFbCDAZLBHFQ8Sbb1rJs0
         gL8gGaLMX2zyvCmZx4tXJYU2+SqcTx49JhQJzNbqZqeqKNjoPZFJwPXvehLtYigoGwl1
         TLdg==
X-Gm-Message-State: AOAM5324u1E3EGXjZZB9rt1BulJ5TaNzMtQXw6kRaYqAbRcH4zRAtb7V
        OnC/in5vrncYT4E4y0PkiUY=
X-Google-Smtp-Source: ABdhPJxWQCvkABAXFEQpSWWHprxz0J735ZuPrUQCO/ZrqeYeAxjmldjFBJxvMrr0bKoJMSiYonO6SA==
X-Received: by 2002:adf:a49d:: with SMTP id g29mr524920wrb.219.1601283741805;
        Mon, 28 Sep 2020 02:02:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k4sm561750wrx.51.2020.09.28.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:02:21 -0700 (PDT)
Date:   Mon, 28 Sep 2020 09:02:20 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Document missing hv_pci_protocol_negotiation()
 parameter
Message-ID: <20200928090220.abgztj5onp6oaltm@liuwe-devbox-debian-v2>
References: <20200925234753.1767227-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925234753.1767227-1-kw@linux.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 25, 2020 at 11:47:53PM +0000, Krzysztof Wilczyński wrote:
> Add missing documentation for the parameter "version" and "num_version"
> of the hv_pci_protocol_negotiation() function and resolve build time
> kernel-doc warnings:
> 
>   drivers/pci/controller/pci-hyperv.c:2535: warning: Function parameter
>   or member 'version' not described in 'hv_pci_protocol_negotiation'
> 
>   drivers/pci/controller/pci-hyperv.c:2535: warning: Function parameter
>   or member 'num_version' not described in 'hv_pci_protocol_negotiation'
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to hyperv-next. Thanks.
